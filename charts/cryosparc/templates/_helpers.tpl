{{/*
Expand the name of the chart.
*/}}
{{- define "cryosparc.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Auth resource name
*/}}
{{- define "cryosparc.auth.name" -}}
{{- printf "%s-auth" (include "cryosparc.name" .) }}
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
Auth labels
*/}}
{{- define "cryosparc.auth.labels" -}}
helm.sh/chart: {{ include "cryosparc.chart" . }}
{{ include "cryosparc.auth.selectorLabels" . }}
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

{{/*
Auth Selector labels
*/}}
{{- define "cryosparc.auth.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ printf "%s-auth" (include "cryosparc.name" .) }}
{{- end }}

{{- define "cryosparc.auth.secretName" }}
{{- printf "%s-auth" (include "cryosparc.name" .) }}
{{- end }}

{{- define "cryosparc.imageTag" }}
{{- if .Values.image.tag }}
{{- .Values.image.tag }}
{{- else if .Values.global.env }}
{{- index .Values.global.env (include "osc.common.environment" .) "image" "tag" }}
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

{{- define "cryosparc.auth.replicas" }}
{{- if .Values.auth.replicas }}
{{- .Values.auth.replicas }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "replicas" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.idpHost" }}
{{- if .Values.auth.idpHost }}
{{- .Values.auth.idpHost }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "idpHost" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.accessGroup" }}
{{- if .Values.auth.accessGroup }}
{{- .Values.auth.accessGroup }}
{{- else if .Values.global.env }}
  {{- if (index .Values.global.env (include "osc.common.environment" .) "auth") }}
    {{- index .Values.global.env (include "osc.common.environment" .) "auth" "accessGroup" }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.ingressHost" }}
{{- if .Values.ingress.host }}
{{- .Values.ingress.host }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "ingress") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "ingress" "host" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.ingressHostAlias" }}
{{- if .Values.ingress.hostAlias }}
{{- .Values.ingress.hostAlias }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "ingress") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "ingress" "hostAlias" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.data.name" }}
{{- printf "%s-data" (include "cryosparc.name" .) }}
{{- end }}

{{- define "cryosparc.alert.receiver" }}
{{- if .Values.alert.receiver }}
  {{- .Values.alert.receiver }}
{{- else if and .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "alert") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "alert" "receiver" }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.maintenance.groups" }}
{{- if and .Values.maintenance .Values.maintenance.groups }}
  {{- .Values.maintenance.groups | toJson | nindent 0 }}
{{- else if .Values.global.env }}
  {{- if and (index .Values.global.env (include "osc.common.environment" .)) }}
    {{- if (index .Values.global.env (include "osc.common.environment" .) "maintenance") }}
      {{- index .Values.global.env (include "osc.common.environment" .) "maintenance" "groups" | toJson | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "cryosparc.nodes" }}
{{- $nodes := (lookup "v1" "Node" "" "").items }}
{{- if $nodes }}
{{- range $node := $nodes }}
{{- $node.metadata.name | toYaml }}
{{- end }}
{{- else }}
{{- .Values.nodes | toYaml }}
{{- end }}
{{- end }}
