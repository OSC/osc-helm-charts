{{/*
Expand the name of the chart.
*/}}
{{- define "webservice.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Auth resource name
*/}}
{{- define "webservice.auth.name" -}}
{{- printf "%s-auth" (include "webservice.name" .) }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "webservice.fullname" -}}
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
{{- define "webservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "webservice.labels" -}}
helm.sh/chart: {{ include "webservice.chart" . }}
{{ include "webservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Auth labels
*/}}
{{- define "webservice.auth.labels" -}}
helm.sh/chart: {{ include "webservice.chart" . }}
{{ include "webservice.auth.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "webservice.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "webservice.name" . }}
{{ include "osc.common.role" . }}
{{- end }}

{{/*
Auth Selector labels
*/}}
{{- define "webservice.auth.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ printf "%s-auth" (include "webservice.name" .) }}
{{ include "osc.common.role" . }}
{{- end }}

{{- define "webservice.auth.secretName" }}
{{- printf "%s-auth" (include "webservice.name" .) }}
{{- end }}

{{- define "webservice.database.databaseName" -}}
{{- if .Values.database.mariadb.enable -}}
{{ required "Must provide database name" .Values.database.mariadb.auth.database }}
{{- else if .Values.database.postgresql.enable -}}
{{ required "Must provide database name" .Values.database.postgresql.auth.database }}
{{- end -}}
{{- end -}}

{{- define "webservice.database.username" -}}
{{- if .Values.database.mariadb.enable -}}
{{ required "Must provide database username" .Values.database.mariadb.auth.username }}
{{- else if .Values.database.postgresql.enable -}}
{{ required "Must provide database username" .Values.database.postgresql.auth.username }}
{{- end -}}
{{- end -}}

{{- define "webservice.database.password" -}}
{{- if .Values.database.mariadb.enable -}}
{{ required "Must provide database password" .Values.database.mariadb.auth.password }}
{{- else if .Values.database.postgresql.enable -}}
{{ required "Must provide database password" .Values.database.postgresql.auth.password }}
{{- end -}}
{{- end -}}

{{- define "webservice.database.url" -}}
{{- if .Values.database.mariadb.enable -}}
{{- $mysqlProtocol := "mysql://" -}}
{{- if eq .Values.appType "rails" -}}
{{- $mysqlProtocol = "mysql2://" -}}
{{- end -}}
{{ printf "%s%s:%s@%s/%s" $mysqlProtocol (include "webservice.database.username" .) (include "webservice.database.password" .) (printf "%s-mariadb" (include "webservice.name" .)) (include "webservice.database.databaseName" .) }}
{{- else if .Values.database.postgresql.enable -}}
{{ printf "postgresql://%s:%s@%s/%s" (include "webservice.database.username" .) (include "webservice.database.password" .) (printf "%s-postgresql" (include "webservice.name" .)) (include "webservice.database.databaseName" .) }}
{{- end -}}
{{- end -}}

{{- define "webservice.imageTag" }}
{{- $tag := .Values.image.tag }}
{{- if .Values.global.env }}
{{- $tag = index .Values.global.env (include "osc.common.environment" .) "image" "tag" }}
{{- end }}
{{ required "Must provide image tag" $tag }}
{{- end }}

{{- define "webservice.replicas" }}
{{- if .Values.replicas }}
{{- .Values.replicas }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "replicas") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "replicas" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.auth.replicas" }}
{{- if .Values.auth.replicas }}
{{- .Values.auth.replicas }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "replicas" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.idpHost" }}
{{- if .Values.auth.idpHost }}
{{- .Values.auth.idpHost }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "idpHost" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.accessGroup" }}
{{- if .Values.auth.accessGroup }}
{{- .Values.auth.accessGroup }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "accessGroup" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.ingressHost" }}
{{- if .Values.ingress.host }}
{{- .Values.ingress.host }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "ingress") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "ingress" "host" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.ingressHostAlias" }}
{{- if .Values.ingress.hostAlias }}
{{- .Values.ingress.hostAlias }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "ingress") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "ingress" "hostAlias" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.data.name" }}
{{- printf "%s-data" (include "webservice.name" .) }}
{{- end }}

{{- define "webservice.alert.receiver" }}
{{- if .Values.alert.receiver }}
  {{- .Values.alert.receiver }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "alert") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "alert" "receiver" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "webservice.maintenance.groups" }}
{{- if and .Values.maintenance .Values.maintenance.groups }}
  {{- .Values.maintenance.groups | toJson | nindent 0 }}
{{- else if .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "maintenance") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "maintenance" "groups" | toJson | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
