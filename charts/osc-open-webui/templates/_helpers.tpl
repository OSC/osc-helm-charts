{{/*
Expand the name of the chart.
*/}}
{{- define "osc-open-webui.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "osc-open-webui.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "osc-open-webui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "osc-open-webui.labels" -}}
helm.sh/chart: {{ include "osc-open-webui.chart" . }}
{{ include "osc-open-webui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "osc-open-webui.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "osc-open-webui.name" . }}
{{- end }}

{{- define "osc-open-webui.config.labels" -}}
helm.sh/chart: {{ include "osc-open-webui.chart" . }}
{{ include "osc-open-webui.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "osc-open-webui.secret.content" -}}
{{- if .Values.global.database.enable -}}
DATABASE_URL: '{{ include "osc-open-webui.database.url" . | b64enc }}'
{{- end }}
{{- if .Values.global.database.enable }}
REDIS_URL: '{{ printf "redis://:%s@open-webui-redis-master.%s.svc.%s:6379/0" .Values.global.redis.password .Release.Namespace .Values.clusterDomain | b64enc }}'
{{- end }}
{{- with (required "Auth must provide webui secret key" .Values.global.webui_secret_key) }}
WEBUI_SECRET_KEY: {{ . | b64enc | quote }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.database.url" -}}
{{- if .Values.global.database.enable }}
{{- $user := .Values.global.postgresql.auth.username }}
{{- $password := .Values.global.postgresql.auth.password }}
{{- $host := printf "%s.%s.svc.%s" .Values.global.postgresql.fullnameOverride .Release.Namespace .Values.clusterDomain }}
{{- $port := .Values.global.postgresql.service.ports.postgresql | int }}
{{- $db := .Values.global.postgresql.auth.database }}
{{- printf "postgresql://%s:%s@%s:%d/%s" $user $password $host $port $db }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.db-wait.content" -}}
{{- if not .Values.global.database.enable -}}
echo "Not using central database, exit"
exit 0
{{- else -}}
echo "Wait for postgresql"
kubectl wait -n {{ .Release.Namespace }} --for=condition=ready pod -l app.kubernetes.io/name=postgresql --timeout=300s
echo "Wait for redis"
kubectl wait -n {{ .Release.Namespace }} --for=condition=ready pod -l app.kubernetes.io/name=redis --timeout=300s
{{- end }}
{{- end }}

{{- define "osc-open-webui.db-migrate.content" -}}
{{- if not .Values.global.database.enable -}}
echo "Not using central database, exit"
exit 0
{{- else -}}
cd /app/backend/open_webui

# Get migration versions
CURRENT=$(alembic current 2>/dev/null | grep -oP '[0-9a-f]{12}' || echo "")
HEAD=$(alembic heads 2>/dev/null | grep -oP '[0-9a-f]{12}' || echo "")

echo "Current migration: $CURRENT"
echo "Expected migration: $HEAD"

TIMEOUT=120
START_TIME=$(date +%s)

if [ "$POD_INDEX" -eq 0 ]; then
  # Primary pod: upgrade if needed
  if [ -n "$HEAD" ] && [ "$CURRENT" != "$HEAD" ]; then
    echo "POD_INDEX=0: Running alembic upgrade head..."
    alembic upgrade head
  else
    echo "POD_INDEX=0: Migrations already up to date"
  fi
else
  # Non-primary pods: wait for primary to complete with timeout
  while [ "$CURRENT" != "$HEAD" ]; do
    ELAPSED=$(($(date +%s) - $START_TIME))
    if [ $ELAPSED -ge $TIMEOUT ]; then
      echo "Timeout after ${TIMEOUT}s waiting for migrations to complete"
      exit 1
    fi
    echo "POD_INDEX=$POD_INDEX: Waiting for migrations (elapsed: ${ELAPSED}s, current: $CURRENT, head: $HEAD)"
    sleep 5
    CURRENT=$(alembic current 2>/dev/null | grep -oP '[0-9a-f]{12}' || echo "")
    HEAD=$(alembic heads 2>/dev/null | grep -oP '[0-9a-f]{12}' || echo "")
  done
  echo "POD_INDEX=$POD_INDEX: Migrations completed successfully"
fi

# Check for local database file and migrate if on primary pod
if [ "$POD_INDEX" -eq 0 ] && [ -f "/app/backend/data/webui.db" ]; then
  echo "Local webui.db found, running postgres migration..."
  cd /app/backend/data
  if /opt/migration/bin/open-webui-postgres-migration; then
    echo "Migration successful, backing up local database..."
    mv /app/backend/data/webui.db /app/backend/data/webui.db.bak
    echo "Local database backed up to webui.db.bak"
  else
    echo "ERROR: postgres migration failed, exiting"
    exit 1
  fi
fi

{{- end }}
{{- end }}
