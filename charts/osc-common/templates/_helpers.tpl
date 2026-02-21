{{/*
Expand the name of the chart.
*/}}
{{- define "osc.common.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
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

{{- define "osc.common.environment" }}
{{- if .Values.global }}
{{- default "production" .Values.global.environment }}
{{- else }}
{{- "production" }}
{{- end }}
{{- end }}

{{- define "osc.common.serviceAccountKey" -}}
osc.edu/service-account
{{- end -}}

{{- define "osc.common.serviceAccountValue" }}
{{- $sa := "" }}
{{- if .Values.global.env }}
{{- $sa = (index .Values.global.env (include "osc.common.environment" .) "serviceAccount") }}
{{- end }}
{{- if not $sa }}
{{- $sa = .Values.global.oscServiceAccount }}
{{- end }}
{{- required "Must provide oscServiceAccount" $sa }}
{{- end }}

{{- define "osc.common.serviceAccount" }}
{{- printf "%s: %s" (include "osc.common.serviceAccountKey" . ) (include "osc.common.serviceAccountValue" .) }}
{{- end }}

{{- define "osc.common.nodeSelectorRoleKey" -}}
node-role.kubernetes.io/{{- .Values.global.nodeSelectorRole }}
{{- end -}}

{{- define "osc.common.nodeSelectorRole" -}}
{{- printf "%s: ''" (include "osc.common.nodeSelectorRoleKey" . ) }}
{{- end -}}

{{- define "osc.common.roleKey" -}}
osc.edu/role
{{- end -}}

{{- define "osc.common.role" -}}
{{ include "osc.common.roleKey" . }}: {{ .Values.global.nodeSelectorRole }}
{{- end -}}

{{- define "osc.common.imagePullSecret.name" }}
{{- .Values.global.imagePullSecret.name }}
{{- end }}

{{- define "osc.common.imagePullSecret" }}
{{- with .Values.global.imagePullSecret }}
{{- printf "{\"auths\":{\"%s\":{\"auth\":\"%s\"}}}" .registry (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}
