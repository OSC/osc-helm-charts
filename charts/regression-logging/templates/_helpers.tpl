{{/*
Expand the name of the chart.
*/}}
{{- define "regression-logging.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "regression-logging.fullname" -}}
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
{{- define "regression-logging.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "regression-logging.labels" -}}
helm.sh/chart: {{ include "regression-logging.chart" . }}
{{ include "regression-logging.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "regression-logging.selectorLabels" -}}
app.kubernetes.io/name: {{ include "regression-logging.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Frontend selector labels
*/}}
{{- define "regression-logging.frontend.selectorLabels" -}}
{{ include "regression-logging.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{/*
Backend selector labels
*/}}
{{- define "regression-logging.backend.selectorLabels" -}}
{{ include "regression-logging.selectorLabels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{/*
Backend connection details
*/}}
{{- define "regression-logging.backend.host" -}}
{{ include "regression-logging.fullname" . }}-backend
{{- end }}

{{- define "regression-logging.backend.port" -}}
{{- default 8001 .Values.backend.port -}}
{{- end }}

{{/*
Generate image name with registry
*/}}
{{- define "regression-logging.image" -}}
{{- $registryName := default .imageRoot.registry .global.imageRegistry }}
{{- $repositoryName := .imageRoot.repository }}
{{- $tag := default "latest" .imageRoot.tag }}
{{- if $registryName }}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
    {{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}
