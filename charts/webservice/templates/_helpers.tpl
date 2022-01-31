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
Chart role name
*/}}
{{- define "webservice.roleName" -}}
{{ include "webservice.fullname" . }}-deploy
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

{{- define "webservice.imagePullSecret" }}
{{- with .Values.imagePullSecret }}
{{- printf "{\"auths\":{\"%s\":{\"auth\":\"%s\"}}}" .registry (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{- define "webservice.auth.secretName" }}
{{- printf "%s-auth" (include "webservice.name" .) }}
{{- end }}

{{- define "webservice.serviceAccount" }}
{{- or .Values.serviceAccount (index .Values.global.env .Values.global.environment "serviceAccount") }}
{{- end }}

{{- define "webservice.idpHost" }}
{{- or .Values.auth.idpHost (index .Values.global.env .Values.global.environment "auth" "idpHost") }}
{{- end }}

{{- define "webservice.accessGroup" }}
{{- index .Values.global.env .Values.global.environment "auth" "accessGroup" }}
{{- end }}

{{- define "webservice.ingressHost" }}
{{- or .Values.ingress.host (index .Values.global.env .Values.global.environment "ingress" "host") }}
{{- end }}
{{- define "webservice.ingressHostAlias" }}
{{- or .Values.ingress.hostAlias (index .Values.global.env .Values.global.environment "ingress" "hostAlias") }}
{{- end }}
