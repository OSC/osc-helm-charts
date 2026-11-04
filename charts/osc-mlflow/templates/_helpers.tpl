{{/*
Expand the name of the chart.
*/}}
{{- define "mlflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mlflow.fullname" -}}
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
Create chart name and version as used in the chart label.
*/}}
{{- define "mlflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mlflow.labels" -}}
helm.sh/chart: {{ include "mlflow.chart" . }}
{{ include "mlflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mlflow.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mlflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mlflow.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mlflow.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
OSC Common helpers
*/}}

{{/*
The environment (default: production)
*/}}
{{- define "mlflow.environment" -}}
{{- default "production" .Values.global.environment }}
{{- end }}

{{/*
Service account label key
*/}}
{{- define "mlflow.serviceAccountKey" -}}
osc.edu/service-account
{{- end }}

{{/*
Service account value (global or environment-specific)
*/}}
{{- define "mlflow.serviceAccountValue" -}}
{{- if .Values.global.oscServiceAccount }}
{{- .Values.global.oscServiceAccount }}
{{- else }}
{{- "" }}
{{- end }}
{{- end }}

{{/*
Service account label as key:value
*/}}
{{- define "mlflow.serviceAccount" -}}
{{ include "mlflow.serviceAccountKey" . }}: {{ include "mlflow.serviceAccountValue" . | quote }}
{{- end }}

{{/*
Node selector role key
*/}}
{{- define "mlflow.nodeSelectorRoleKey" -}}
{{- default "osc.edu/node-role" .Values.global.nodeSelectorRoleKey }}
{{- end }}

{{/*
Node selector role value
*/}}
{{- define "mlflow.nodeSelectorRoleValue" -}}
{{- default "webservices" .Values.global.nodeSelectorRole }}
{{- end }}

{{/*
Node selector as key:value
*/}}
{{- define "mlflow.nodeSelectorRole" -}}
{{ include "mlflow.nodeSelectorRoleKey" . }}: {{ include "mlflow.nodeSelectorRoleValue" . | quote }}
{{- end }}

{{/*
Image pull secret name
*/}}
{{- define "mlflow.imagePullSecretName" -}}
{{- default "osc-registry" .Values.global.imagePullSecret.name }}
{{- end }}

{{/*
Common labels including OSC service account
*/}}
{{- define "mlflow.commonLabels" -}}
{{ include "mlflow.labels" . }}
{{ include "mlflow.serviceAccount" . }}
receiver: {{ .Values.global.alert.receiver | quote }}
{{- end }}

{{/*
Selector labels including OSC service account
*/}}
{{- define "mlflow.commonSelectorLabels" -}}
{{ include "mlflow.selectorLabels" . }}
{{ include "mlflow.serviceAccountKey" . }}: {{ include "mlflow.serviceAccountValue" . | quote }}
{{- end }}