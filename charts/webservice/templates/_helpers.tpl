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
{{- end }}

{{/*
Auth Selector labels
*/}}
{{- define "webservice.auth.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ printf "%s-auth" (include "webservice.name" .) }}
{{- end }}

{{- define "webservice.auth.secretName" }}
{{- printf "%s-auth" (include "webservice.name" .) }}
{{- end }}

{{- define "webservice.imageTag" }}
{{- if .Values.image.tag }}
{{- .Values.image.tag }}
{{- else if .Values.global.env }}
{{- index .Values.global.env (include "osc.common.environment" .) "image" "tag" }}
{{- end }}
{{- end }}

{{- define "webservice.idpHost" }}
{{- if .Values.auth.idpHost }}
{{- .Values.auth.idpHost }}
{{- else if .Values.global.env }}
{{- index .Values.global.env (include "osc.common.environment" .) "auth" "idpHost" }}
{{- end }}
{{- end }}

{{- define "webservice.accessGroup" }}
{{- if .Values.auth.accessGroup }}
{{- .Values.auth.accessGroup }}
{{- else if .Values.global.env }}
{{- index .Values.global.env (include "osc.common.environment" .) "auth" "accessGroup" }}
{{- end }}
{{- end }}

{{- define "webservice.ingressHost" }}
{{- if .Values.ingress.host }}
{{- .Values.ingress.host }}
{{- else if .Values.global.env }}
{{- index .Values.global.env (include "osc.common.environment" .) "ingress" "host" }}
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
