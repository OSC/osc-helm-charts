{{/*
Expand the name of the chart.
*/}}
{{- define "dynamo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dynamo.fullname" -}}
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
{{- define "dynamo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dynamo.labels" -}}
helm.sh/chart: {{ include "dynamo.chart" . }}
{{ include "dynamo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dynamo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dynamo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dynamo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dynamo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
image-puller labels
*/}}
{{- define "dynamo.image-puller.labels" -}}
helm.sh/chart: {{ include "dynamo.chart" . }}
{{ include "dynamo.image-puller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
image-puller selector labels
*/}}
{{- define "dynamo.image-puller.selectorLabels" -}}
app.kubernetes.io/name: image-puller
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Image tag helper */}}
{{- define "dynamo.image" -}}
{{- $tag := printf "%s-osc-r%s" (.Values.image.tag | default .Chart.AppVersion) .Values.image.release }}
{{- printf "%s/%s:%s" .Values.global.imagePullSecret.registry .Values.image.repository $tag }}
{{- end }}
