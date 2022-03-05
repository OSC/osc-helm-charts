{{/*
Expand the name of the chart.
*/}}
{{- define "osc.common.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "osc.common.environment" }}
{{- if .Values.global }}
{{- default "production" .Values.global.environment }}
{{- else }}
{{- "production" }}
{{- end }}
{{- end }}

{{- define "osc.common.serviceAccount" }}
{{- $sa := "" }}
{{- if .Values.global.env }}
{{- $sa = (index .Values.global.env (include "osc.common.environment" .) "serviceAccount") }}
{{- end }}
{{- if not $sa }}
{{- $sa = .Values.global.oscServiceAccount }}
{{- end }}
{{- required "Must provide oscServiceAccount" $sa }}
{{- end }}

{{- define "osc.common.serviceAccountLabel" -}}
osc.edu/service-account
{{- end -}}

{{- define "osc.common.imagePullSecret.name" }}
{{- .Values.global.imagePullSecret.name }}
{{- end }}

{{- define "osc.common.imagePullSecret" }}
{{- with .Values.global.imagePullSecret }}
{{- printf "{\"auths\":{\"%s\":{\"auth\":\"%s\"}}}" .registry (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}
