{{/*
Expand the name of the chart.
*/}}
{{- define "osc-open-webui.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Auth resource name
*/}}
{{- define "osc-open-webui.auth.name" -}}
{{- printf "%s-auth" (include "osc-open-webui.name" .) }}
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
Auth labels
*/}}
{{- define "osc-open-webui.auth.labels" -}}
helm.sh/chart: {{ include "osc-open-webui.chart" . }}
{{ include "osc-open-webui.auth.selectorLabels" . }}
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

{{/*
Auth Selector labels
*/}}
{{- define "osc-open-webui.auth.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ printf "%s-auth" (include "osc-open-webui.name" .) }}
{{- end }}

{{- define "osc-open-webui.auth.secretName" }}
{{- printf "%s-auth" (include "osc-open-webui.name" .) }}
{{- end }}

{{- define "osc-open-webui.imageTag" }}
{{- if .Values.image.tag }}
{{- .Values.image.tag }}
{{- else if .Values.global.env }}
{{- index .Values.global.env (include "osc.common.environment" .) "image" "tag" }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.replicas" }}
{{- if .Values.replicas }}
{{- .Values.replicas }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "replicas") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "replicas" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.auth.replicas" }}
{{- if .Values.auth.replicas }}
{{- .Values.auth.replicas }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "replicas" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.idpHost" }}
{{- if .Values.auth.idpHost }}
{{- .Values.auth.idpHost }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "idpHost" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.accessGroup" }}
{{- if .Values.auth.accessGroup }}
{{- .Values.auth.accessGroup }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "accessGroup" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "osc-open-webui.ingressHost" }}
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

{{- define "osc-open-webui.ingressHostAlias" }}
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

{{- define "osc-open-webui.data.name" }}
{{- printf "%s-data" (include "osc-open-webui.name" .) }}
{{- end }}

{{- define "osc-open-webui.alert.receiver" }}
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

{{- define "osc-open-webui.maintenance.groups" }}
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
