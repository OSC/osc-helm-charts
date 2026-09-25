{{/*
Expand the name of the chart.
*/}}
{{- define "osc-chat.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "osc-chat.fullname" -}}
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
{{- define "osc-chat.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "osc-chat.labels" -}}
helm.sh/chart: {{ include "osc-chat.chart" . }}
{{ include "osc-chat.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "osc-chat.selectorLabels" -}}
app.kubernetes.io/name: {{ include "osc-chat.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "osc-chat.serviceAccountName" -}}
{{- include "osc-chat.fullname" . }}
{{- end }}

{{/*
Generate image name with registry
*/}}
{{- define "osc-chat.image" -}}
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
Frontend selector labels
*/}}
{{- define "osc-chat.frontend.selectorLabels" -}}
{{ include "osc-chat.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{/*
Backend selector labels
*/}}
{{- define "osc-chat.backend.selectorLabels" -}}
{{ include "osc-chat.selectorLabels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "osc-chat.worker.selectorLabels" -}}
{{ include "osc-chat.selectorLabels" . }}
app.kubernetes.io/component: worker
{{- end }}

{{/*
PVC labels
*/}}
{{- define "osc-chat.pvcLabels" -}}
{{- with .Values.global.pvcLabels }}
{{- tpl (toYaml .) $ }}
{{- end }}
{{- end }}

{{/*
PVC annotations
*/}}
{{- define "osc-chat.pvcAnnotations" -}}
{{- with .Values.global.pvcAnnotations }}
{{- tpl (toYaml .) $ }}
{{- end }}
{{- end }}

{{/*
PostgreSQL connection details (using dependency chart naming)
*/}}
{{- define "osc-chat.postgresql.host" -}}
{{- if .Values.database.postgresql.enable -}}
{{ include "osc-chat.fullname" . }}-postgresql
{{- else -}}
{{- .Values.externalDatabase.host -}}
{{- end -}}
{{- end }}

{{- define "osc-chat.postgresql.port" -}}
5432
{{- end }}

{{- define "osc-chat.postgresql.database" -}}
{{ .Values.database.postgresql.auth.database }}
{{- end }}

{{- define "osc-chat.postgresql.username" -}}
{{ .Values.database.postgresql.auth.username }}
{{- end }}

{{/*
Redis connection details (using dependency chart naming)
*/}}
{{- define "osc-chat.redis.host" -}}
{{ include "osc-chat.fullname" . }}-redis-master
{{- end }}

{{- define "osc-chat.redis.port" -}}
6379
{{- end }}

{{/*
RabbitMQ connection details (using dependency chart naming)
*/}}
{{- define "osc-chat.rabbitmq.host" -}}
{{ include "osc-chat.fullname" . }}-rabbitmq
{{- end }}

{{- define "osc-chat.rabbitmq.port" -}}
5672
{{- end }}

{{/*
MinIO connection details (using dependency chart naming)
*/}}
{{- define "osc-chat.minio.host" -}}
{{ include "osc-chat.fullname" . }}-minio
{{- end }}

{{- define "osc-chat.minio.port" -}}
9000
{{- end }}

{{/*
Backend connection details
*/}}
{{- define "osc-chat.backend.host" -}}
{{ include "osc-chat.fullname" . }}-backend
{{- end }}

{{- define "osc-chat.backend.port" -}}
8001
{{- end }}

{{/*
Ingest Worker selector labels
*/}}
{{- define "osc-chat.ingestWorker.selectorLabels" -}}
{{ include "osc-chat.selectorLabels" . }}
app.kubernetes.io/component: ingest-worker
{{- end }}

{{/*
Crawlee selector labels
*/}}
{{- define "osc-chat.crawlee.selectorLabels" -}}
{{ include "osc-chat.selectorLabels" . }}
app.kubernetes.io/component: crawlee
{{- end }}

{{/*
Qdrant selector labels
*/}}
{{- define "osc-chat.qdrant.selectorLabels" -}}
{{ include "osc-chat.selectorLabels" . }}
app.kubernetes.io/component: qdrant
app.kubernetes.io/name: qdrant
{{- end }}

{{/*
LLM server host
*/}}
{{- define "osc-chat.llm_server.host" -}}
{{- if and (index .Values "vllm-stack" "enabled") ( index .Values "vllm-stack" "routerSpec" "enableRouter") -}}
http://{{ .Release.Name }}-router-service/v1
{{- else -}}
{{ required "llm server host must be defined if not deploying vLLM" .Values.global.llm.host }}
{{- end -}}
{{- end }}

{{/*
Embedding model
*/}}
{{- define "osc-chat.embedding.host" -}}
{{- if and (index .Values "vllm-stack" "enabled") ( index .Values "vllm-stack" "routerSpec" "enableRouter") -}}
http://{{ .Release.Name }}-router-service/v1
{{- else -}}
{{- default (include "osc-chat.llm_server.host" .) .Values.global.embedding.host -}}
{{- end -}}
{{- end }}
{{- define "osc-chat.embedding.model" -}}
{{ required "embedding model must be defined" .Values.global.embedding.model }}
{{- end }}

{{- define "osc-chat.app.config" -}}
# Service URLs
#POSTGRES_HOST: {{ include "osc-chat.postgresql.host" . | quote }}
POSTGRES_PORT: {{ include "osc-chat.postgresql.port" . | quote }}
POSTGRES_DB: {{ include "osc-chat.postgresql.database" . | quote }}
POSTGRES_USER: {{ include "osc-chat.postgresql.username" . | quote }}

# ai-ta-backend expected PostgreSQL envs (aliases)
POSTGRES_ENDPOINT: {{ include "osc-chat.postgresql.host" . | quote }}
POSTGRES_DATABASE: {{ include "osc-chat.postgresql.database" . | quote }}
POSTGRES_USERNAME: {{ include "osc-chat.postgresql.username" . | quote }}

REDIS_HOST: {{ include "osc-chat.redis.host" . | quote }}
REDIS_PORT: {{ include "osc-chat.redis.port" . | quote }}

RABBITMQ_HOST: {{ include "osc-chat.rabbitmq.host" . | quote }}
RABBITMQ_PORT: {{ include "osc-chat.rabbitmq.port" . | quote }}
RABBITMQ_QUEUE: {{ include "osc-chat.fullname" . }}

QDRANT_URL: "http://{{ include "osc-chat.fullname" . }}-qdrant:6333"
MINIO_URL: "http://{{ include "osc-chat.fullname" . }}-minio:9000"
MINIO_PUBLIC_URL: {{ printf "https://%s" (.Values.minio.ingress.hostname)  | quote }}
KEYCLOAK_URL: {{ .Values.keycloak.url | quote }}
LLM_URL: {{ include "osc-chat.llm_server.host" . | quote }}
EMBEDDING_URL: {{ include "osc-chat.embedding.host" . | quote }}
EMBEDDING_MODEL: {{ include "osc-chat.embedding.model" . | quote }}

# Application specific
QDRANT_COLLECTION_NAME: {{ include "osc-chat.fullname" . | quote }}
S3_BUCKET_NAME: {{ tpl .Values.worker.env.S3_BUCKET_NAME . | quote }}
{{- end }}

{{- define "osc-chat.app.secrets" -}}
# Database credentials (matching dependency chart passwords)
POSTGRES_PASSWORD: {{ .Values.database.postgresql.auth.password | b64enc | quote }}

# Redis credentials (matching dependency chart passwords)
REDIS_PASSWORD: {{ .Values.database.redis.auth.password | b64enc | quote }}
REDIS_URL: {{ printf "redis://:%s@%s:%s/0" .Values.database.redis.auth.password (include "osc-chat.redis.host" .) (include "osc-chat.redis.port" .) | b64enc | quote }}

# RabbitMQ credentials (matching dependency chart passwords)
RABBITMQ_PASSWORD: {{ .Values.rabbitmq.auth.password | b64enc | quote }}
RABBITMQ_URL: {{ printf "amqp://%s:%s@%s:%s" .Values.rabbitmq.auth.username .Values.rabbitmq.auth.password (include "osc-chat.rabbitmq.host" .) (include "osc-chat.rabbitmq.port" .) | b64enc | quote }}

# MinIO credentials (matching dependency chart passwords)
MINIO_ACCESS_KEY: {{ .Values.minio.auth.rootUser | b64enc | quote }}
MINIO_SECRET_KEY: {{ .Values.minio.auth.rootPassword | b64enc | quote }}

# API keys (OSC Chat specific)
{{- if .Values.secrets.api.openaiKey }}
OPENAI_API_KEY: {{ .Values.secrets.api.openaiKey | b64enc | quote }}
{{- else }}
OPENAI_API_KEY: ""
{{- end }}
{{- if .Values.qdrant.apiKey }}
QDRANT_API_KEY: {{ .Values.qdrant.apiKey | b64enc | quote }}
{{- end }}
{{- if .Values.secrets.api.posthogKey }}
POSTHOG_API_KEY: {{ .Values.secrets.api.posthogKey | b64enc | quote }}
{{- else }}
POSTHOG_API_KEY: {{ "dummy-posthog-key" | b64enc | quote }}
{{- end }}
{{- end }}