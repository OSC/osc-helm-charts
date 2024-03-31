{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "paas.chart" -}}
{{- printf "%s-%s" $.Chart.Name $.Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paas.labels" -}}
{{- $namespace := index . 0 -}}
{{- $top := index . 1 -}}
helm.sh/chart: paas
app.kubernetes.io/instance: {{ $namespace.name }}
app.kubernetes.io/name: {{ $namespace.name }}
{{- if $top.Chart.AppVersion }}
app.kubernetes.io/version: {{ $top.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ $top.Release.Service }}
{{- end }}

{{- define "paas.imagePullSecret" }}
{{- $namespace := index . 0 -}}
{{- $top := index . 1 -}}
{{- $username := required "Registry username is required" $namespace.imagePullSecret.username -}}
{{- $password := required "Registry password is required" $namespace.imagePullSecret.password -}}
{{- printf "{\"auths\":{\"%s\":{\"auth\":\"%s\"}}}" $top.Values.global.imagePullSecret.registry (printf "%s:%s" $username $password | b64enc) | b64enc }}
{{- end }}
