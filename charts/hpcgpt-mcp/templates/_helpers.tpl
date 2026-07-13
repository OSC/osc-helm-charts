{{/*
Expand the name of the chart.
*/}}
{{- define "hpcgpt-mcp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hpcgpt-mcp.fullname" -}}
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
{{- define "hpcgpt-mcp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hpcgpt-mcp.labels" -}}
helm.sh/chart: {{ include "hpcgpt-mcp.chart" . }}
{{ include "hpcgpt-mcp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hpcgpt-mcp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hpcgpt-mcp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hpcgpt-mcp.serviceAccountName" -}}
{{- include "hpcgpt-mcp.name" . }}
{{- end }}

{{/*
Generate image name with registry
*/}}
{{- define "hpcgpt-mcp.image" -}}
{{- $registryName := default .imageRoot.registry ((.global).imageRegistry) -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $separator := ":" -}}

{{- $termination := .imageRoot.tag | toString -}}
{{- if not .imageRoot.tag }}
  {{- if .chart }}
    {{- $termination = .chart.AppVersion | toString -}}
  {{- end -}}
{{- end -}}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end -}}
{{- $testSuffix := "" }}
{{- if eq .env "test" }}
  {{- $testSuffix = "-test" }}
{{- end }}
{{- if $registryName }}
    {{- printf "%s/%s%s%s%s" $registryName $repositoryName $separator $termination $testSuffix -}}
{{- else -}}
    {{- printf "%s%s%s%s"  $repositoryName $separator $termination $testSuffix -}}
{{- end -}}
{{- end -}}

{{/*
OSC Chat MCP selector labels
*/}}
{{- define "hpcgpt-mcp.osc_chat.selectorLabels" -}}
{{ include "hpcgpt-mcp.selectorLabels" . }}
app.kubernetes.io/component: osc_chat
{{- end }}
