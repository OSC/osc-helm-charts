{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus.fullname" -}}
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
{{- define "prometheus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prometheus.labels" -}}
helm.sh/chart: {{ include "prometheus.chart" . }}
{{ include "prometheus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prometheus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prometheus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prometheus.serviceAccountName" -}}
{{- default (include "prometheus.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Selector proxy labels
*/}}
{{- define "prometheus-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.proxy.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common proxy labels
*/}}
{{- define "prometheus-proxy.labels" -}}
helm.sh/chart: {{ include "prometheus.chart" . }}
{{ include "prometheus-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.proxy.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector blackbox-exporter labels
*/}}
{{- define "blackbox-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.blackboxExporter.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common blackbox-exporter labels
*/}}
{{- define "blackbox-exporter.labels" -}}
helm.sh/chart: {{ include "prometheus.chart" . }}
{{ include "blackbox-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.blackboxExporter.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector ssl-exporter labels
*/}}
{{- define "ssl-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.sslExporter.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common ssl-exporter labels
*/}}
{{- define "ssl-exporter.labels" -}}
helm.sh/chart: {{ include "prometheus.chart" . }}
{{ include "ssl-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.sslExporter.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector dcgm-exporter labels
*/}}
{{- define "prometheus-dcgm-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ index .Values "dcgm-exporter" "nameOverride" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common dcgm-exporter labels
*/}}
{{- define "prometheus-dcgm-exporter.labels" -}}
helm.sh/chart: {{ include "prometheus.chart" . }}
{{ include "prometheus-dcgm-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ index .Values "dcgm-exporter" "image" "tag" | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
