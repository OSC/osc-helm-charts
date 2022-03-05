{{/*
Expand the name of the chart.
*/}}
{{- define "osc.common.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "osc.common.serviceAccount" }}
{{- required "Must provide global.oscServiceAccount" .Values.global.oscServiceAccount }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "osc.common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "osc.common.labels" -}}
helm.sh/chart: {{ include "osc.common.chart" . }}
{{ include "osc.common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "osc.common.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "osc.common.name" . }}
{{- end }}

{{- define "osc.common.imagePullSecret" }}
{{- with .Values.global.imagePullSecret }}
{{- printf "{\"auths\":{\"%s\":{\"auth\":\"%s\"}}}" .registry (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}
