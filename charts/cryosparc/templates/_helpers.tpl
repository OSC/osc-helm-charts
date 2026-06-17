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
app.kubernetes.io/component: {{ .Chart.Name }}
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

{{- define "cryosparc.isV5" -}}
{{- $version := semver (include "cryosparc.imageTag" .) -}}
{{- if eq ($version.Major | int) 5 }}
true
{{- end }}
{{- end -}}

{{/*
env for cryosparc
Defined here so that version changes in labels of the configmap won't automatically trigger pod restart
*/}}
{{- define "cryosparc.env" -}}
# Instance Configuration
CRYOSPARC_DB_PATH: "/opt/cryosparc_master/database"
CRYOSPARC_BASE_PORT: {{ .Values.global.basePort | quote }}
CRYOSPARC_DB_CONNECTION_TIMEOUT_MS: "20000"
# Security
CRYOSPARC_INSECURE: "false"
CRYOSPARC_DB_ENABLE_AUTH: "true"
# Cluster Integration
CRYOSPARC_CLUSTER_JOB_MONITOR_INTERVAL: "10"
CRYOSPARC_CLUSTER_JOB_MONITOR_MAX_RETRIES: "1000000"
# Project Configuration
CRYOSPARC_PROJECT_DIR_PREFIX: "CS-"
# Development
CRYOSPARC_DEVELOP: "false"
# Other
CRYOSPARC_CLICK_WRAP: "true"
# Required if the owner of the script is different from the caller
CRYOSPARC_FORCE_USER: "true"
# Skip the hostname check
CRYOSPARC_FORCE_HOSTNAME: "true"
{{- end -}}

{{/*
Run script for cryosparc
Defined here so that version changes in labels of the configmap won't automatically trigger pod restart
*/}}
{{- define "cryosparc.run.content" -}}
export CRYOSPARC_MASTER_HOSTNAME="${MY_NODE_NAME}"
cryosparcm start database
cryosparcm database fixport
cryosparcm stop
sleep 5
set -e
echo "Create cryosparc directory"
mkdir -p {{ tpl .Values.mounts.home . }}/.cryosparc
echo "Write license"
cat /run/secrets/.admin/license > {{ tpl .Values.mounts.home . }}/.cryosparc/license
echo "Start cryosparc"
cryosparcm start
# Do not fail if status has non-zero exit code
set +e
cryosparcm status
set -e
echo "Creating an admin user"
{{- if (include "cryosparc.isV5" .) }}
cryosparcm user create \
--email "$(cat /run/secrets/.admin/email)"  --password "$(cat /run/secrets/.admin/password)" \
--username admin --firstname SciApps --lastname Admin --role admin || true
{{- else }}
cryosparcm cli \
"create_user('initial', '$(cat /run/secrets/.admin/email)', '$(cat /run/secrets/.admin/password)', 'admin', 'SciApps', 'Admin', True)"
{{- end }}
echo "Updating cluster lanes"
ls -d -1 /opt/cryosparc_master/lanes/* |while read x; do
  cd $x
  cryosparcm cluster connect
done
{{- if not (include "cryosparc.isV5" .) }}
echo "Set account variable"
cryosparcm cli "set_cluster_configuration_custom_vars({'account': '{{ tpl .Values.global.project .}}' })"
{{- end }}
set +e
echo "Keep CryoSPARC running"
while true; do
  sleep 3600
done
{{- end -}}
