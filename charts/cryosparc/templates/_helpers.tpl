{{/*
Expand the name of the chart.
*/}}
{{- define "cryosparc.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cryosparc.fullname" -}}
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
{{- define "cryosparc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cryosparc.labels" -}}
helm.sh/chart: {{ include "cryosparc.chart" . }}
{{ include "cryosparc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cryosparc.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "cryosparc.name" . }}
{{- end }}

{{- define "cryosparc.imageTag" }}
{{- if .Values.image.tag }}
{{- tpl .Values.image.tag . }}
{{- else if and .Values.global.env (index .Values.global.env (include "osc.common.environment" .) "image" "tag") }}
  {{- index .Values.global.env (include "osc.common.environment" .) "image" "tag" }}
{{- else if .Chart.AppVersion }}
  {{- .Chart.AppVersion }}
{{- end }}
{{- end }}

{{- define "cryosparc.replicas" }}
{{- if .Values.replicas }}
{{- .Values.replicas }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "replicas") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "replicas" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.ingressHost" }}
{{- if .Values.ingress.host }}
  {{- .Values.ingress.host }}
{{- else if and .Values.global.ingress.host }}
  {{- .Values.global.ingress.host }}
{{- end }}
{{- end }}

{{- define "cryosparc.ingressHostAlias" }}
{{- if .Values.ingress.hostAlias }}
  {{- .Values.ingress.hostAlias }}
{{- else if and .Values.global.ingress.hostAlias }}
  {{- .Values.global.ingress.hostAlias }}
{{- end }}
{{- end }}

{{- define "cryosparc.data.name" }}
{{- printf "%s-data" (include "cryosparc.name" .) }}
{{- end }}

{{- define "cryosparc.alert.receiver" }}
{{- if .Values.global.alert.receiver }}
  {{- .Values.global.alert.receiver }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "alert") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "alert" "receiver" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.nodes" -}}
{{- $nodeNames := list -}}
{{- $nodes := (lookup "v1" "Node" "" "").items -}}
  {{- if $nodes -}}
    {{- range $node := $nodes -}}
      {{- $nodeNames = append $nodeNames $node.metadata.name -}}
    {{- end -}}
  {{- end -}}
{{- $nodeNames | toJson -}}
{{- end -}}
