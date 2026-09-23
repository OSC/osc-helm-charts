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
