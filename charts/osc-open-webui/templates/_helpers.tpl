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

{{- define "osc-open-webui.data.name" }}
{{- printf "%s-data" (include "osc-open-webui.name" .) }}
{{- end }}

{{- define "osc-open-webui.api.name" -}}
{{- printf "%s-api" (include "osc-open-webui.name" .) }}
{{- end }}

{{- define "osc-open-webui.api.labels" -}}
helm.sh/chart: {{ include "osc-open-webui.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ printf "%s-api" (include "osc-open-webui.name" .) }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "osc-open-webui.api.hostAlias" }}
{{- $hostAliasParts := splitList "." .Values.global.ingress.hostAlias }}
{{- $hostAliasName := first $hostAliasParts }}
{{- $hostAliasDomain := rest $hostAliasParts | join "." }}
{{- printf "%s-api.%s" $hostAliasName $hostAliasDomain }}
{{- end }}

{{- define "osc-open-webui.api.host" }}
{{- $parts := splitList "." .Values.global.ingress.host }}
{{- $name := first $parts }}
{{- $domain := rest $parts | join "." }}
{{- printf "%s-api.%s" $name $domain }}
{{- end }}
