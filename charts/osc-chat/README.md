# osc-chat

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.3](https://img.shields.io/badge/AppVersion-0.1.3-informational?style=flat-square)

A Helm chart for the OSC Chat service

## OSC Chat Chart

This chart handles the deployment of OSC Chat resources.

Components:

* OSC chat frontend
* OSC chat backend
* OSC chat worker
* Postgresql
* Redis
* Rabbitmq
* Minio
* Qdrant
* Crawlee
* Keycloak client
* LLM and embedding model server

## Usage

The following is the minimal values to deploy this chart:

```yaml
---
global:
  imagePullSecret:
    password: <webservices-read password>
  ingress:
    host: <Ingress host>
    hostAlias: <Ingress host alias>
  llm:
    host: <LLM server host>
  embedding:
    model: <Embedding model name>
database:
  postgresql:
    auth:
      postgresPassword: <postgres root password>
      password: <postgres database password>
  redis:
    auth:
      password: <redis password>

rabbitmq:
  auth:
    username: <rabbitmq root username>
    password: <rabbitmq root password>

minio:
  auth:
    rootUser: <minio root username>
    rootPassword: <minio root password>
  ingress:
    hostname: <minio host name>

secrets:
  api:
    openaiKey: <LLM server API key>
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts | database | 0.17.0 |
| https://qdrant.github.io/qdrant-helm | qdrant | 1.16.3 |
| oci://docker-registry.osc.edu/kubernetes/vllm | vllm-stack | 0.1.11-osc-r1 |
| oci://registry-1.docker.io/bitnamicharts | minio | 17.0.21 |
| oci://registry-1.docker.io/bitnamicharts | rabbitmq | 16.0.14 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imageRegistry | string | `"docker-registry.osc.edu"` |  |
| global.imagePullSecret.name | string | `"osc-registry"` |  |
| global.imagePullSecret.password | string | **required** | OSC registry password |
| global.oscServiceAccount | string | `"oscchat"` |  |
| global.database.allowIngress | bool | `true` |  |
| global.security.allowInsecureImages | bool | `true` |  |
| global.storageClass | string | `"local-ess"` |  |
| global.pvcLabels."osc.edu/service-account" | string | `"oscchat"` |  |
| global.pvcAnnotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| global.fileset | string | `"PZS0645"` |  |
| global.llm.host | string | `""` |  |
| global.embedding.host | string | `""` |  |
| global.embedding.model | string | `""` |  |
| global.alert.receiver | string | `"sciapps"` |  |
| global.ingress.host | string | `""` |  |
| global.ingress.hostAlias | string | `""` |  |
| database.postgresql.schema.enabled | bool | `true` |  |
| database.postgresql.enable | bool | `true` |  |
| database.postgresql.imagePullSecret.enable | bool | `false` |  |
| database.postgresql.auth.postgresPassword | string | `"secret"` |  |
| database.postgresql.auth.database | string | `"name"` |  |
| database.postgresql.auth.username | string | `"name"` |  |
| database.postgresql.auth.password | string | `"secret"` |  |
| database.postgresql.primary.persistence.annotations."osc.edu/fileset" | string | `"{{ .Values.global.fileset }}"` |  |
| database.redis.enable | bool | `true` |  |
| database.redis.auth.password | string | `"secret"` |  |
| database.redis.master.persistence.annotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| minio.enable | bool | `true` |  |
| minio.image.repository | string | `"kubernetes/bitnami/minio"` |  |
| minio.image.tag | string | `"2025.7.23-debian-12-r5"` |  |
| minio.image.pullSecrets[0] | string | `"osc-registry"` |  |
| minio.defaultBuckets | string | `"osc-chat"` |  |
| minio.commonLabels.receiver | string | `"{{ index .Values.global.alert.receiver }}"` |  |
| minio.clientImage.repository | string | `"kubernetes/bitnami/minio-client"` |  |
| minio.clientImage.tag | string | `"2025.7.21-debian-12-r3"` |  |
| minio.clientImage.pullSecrets[0] | string | `"osc-registry"` |  |
| minio.console.image.repository | string | `"kubernetes/bitnami/minio-object-browser"` |  |
| minio.console.image.tag | string | `"2.0.2-debian-12-r3"` |  |
| minio.console.image.pullSecrets[0] | string | `"osc-registry"` |  |
| minio.imagePullSecret.enable | bool | `false` |  |
| minio.metrics.enabled | bool | `true` |  |
| minio.metrics.serviceMonitor.enabled | bool | `true` |  |
| minio.metrics.serviceMonitor.interval | string | `"60s"` |  |
| minio.metrics.serviceMonitor.relabelings[0].sourceLabels[0] | string | `"__meta_kubernetes_service_label_receiver"` |  |
| minio.metrics.serviceMonitor.relabelings[0].targetLabel | string | `"receiver"` |  |
| minio.persistence.annotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| minio.auth.rootUser | string | `"minioadmin"` |  |
| minio.auth.rootPassword | string | `"minioadmin"` |  |
| minio.ingress.enabled | bool | `true` |  |
| minio.ingress.ingressClassName | string | `"nginx"` |  |
| minio.ingress.hostname | string | `""` |  |
| minio.ingress.tls | bool | `true` |  |
| minio.ingress.path | string | `"/"` |  |
| minio.ingress.pathType | string | `"Prefix"` |  |
| minio.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt"` |  |
| minio.ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"true"` |  |
| minio.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` |  |
| qdrant.enable | bool | `true` |  |
| qdrant.resources.limits.cpu | int | `4` |  |
| qdrant.resources.limits.memory | string | `"8Gi"` |  |
| qdrant.resources.requests.cpu | int | `4` |  |
| qdrant.resources.requests.memory | string | `"8Gi"` |  |
| qdrant.storageClass | string | `nil` |  |
| qdrant.additionalLabels.receiver | string | `"sciapps"` |  |
| qdrant.metrics.serviceMonitor.enabled | bool | `true` |  |
| qdrant.metrics.serviceMonitor.scrapeInterval | string | `"60s"` |  |
| qdrant.metrics.serviceMonitor.relabelings[0].sourceLabels[0] | string | `"__meta_kubernetes_service_label_receiver"` |  |
| qdrant.metrics.serviceMonitor.relabelings[0].targetLabel | string | `"receiver"` |  |
| qdrant.image.repository | string | `"docker-registry.osc.edu/kubernetes/qdrant/qdrant"` |  |
| qdrant.image.tag | string | `"v1.16.3"` |  |
| qdrant.image.useUnprivilegedImage | bool | `true` |  |
| qdrant.persistence.storageClassName | string | `"local-path"` |  |
| qdrant.snapshotPersistence.enabled | bool | `true` |  |
| qdrant.snapshotPersistence.storageClassName | string | `"local-ess"` |  |
| qdrant.snapshotPersistence.annotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| qdrant.snapshotPersistence.additionalLabels."osc.edu/service-account" | string | `"oscchat"` |  |
| qdrant.imagePullSecrets[0].name | string | `"osc-registry"` |  |
| qdrant.apiKey | bool | `true` |  |
| rabbitmq.enable | bool | `true` |  |
| rabbitmq.image.repository | string | `"kubernetes/bitnami/rabbitmq"` |  |
| rabbitmq.image.tag | string | `"4.1.3-debian-12-r1"` |  |
| rabbitmq.image.pullSecrets[0] | string | `"osc-registry"` |  |
| rabbitmq.imagePullSecret.enable | bool | `false` |  |
| rabbitmq.resources.limits.cpu | string | `"750m"` |  |
| rabbitmq.resources.limits.memory | string | `"768Mi"` |  |
| rabbitmq.resources.requests.cpu | string | `"500m"` |  |
| rabbitmq.resources.requests.memory | string | `"512Mi"` |  |
| rabbitmq.commonLabels.receiver | string | `"{{ index .Values.global.alert.receiver }}"` |  |
| rabbitmq.metrics.enabled | bool | `true` |  |
| rabbitmq.metrics.podAnnotations."prometheus.io/scrape" | string | `"false"` |  |
| rabbitmq.metrics.serviceMonitor.default.enabled | bool | `true` |  |
| rabbitmq.metrics.serviceMonitor.default.interval | string | `"60s"` |  |
| rabbitmq.metrics.serviceMonitor.targetLabels[0] | string | `"receiver"` |  |
| rabbitmq.auth.username | string | `"guest"` |  |
| rabbitmq.auth.password | string | `"guest"` |  |
| rabbitmq.persistence.annotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| rabbitmq.rbac.create | bool | `false` |  |
| backend.enabled | bool | `true` |  |
| backend.ingress.enabled | bool | `false` |  |
| backend.image.repository | string | `"kubernetes/hpcgpt/backend"` |  |
| backend.image.tag | string | `"v0.1.1"` |  |
| backend.image.pullPolicy | string | `"Always"` |  |
| backend.imagePullSecret.enable | bool | `false` |  |
| backend.replicaCount | int | `1` |  |
| backend.service.type | string | `"ClusterIP"` |  |
| backend.service.port | int | `8001` |  |
| backend.env.FLASK_ENV | string | `"production"` |  |
| backend.resources.limits.cpu | int | `1` |  |
| backend.resources.limits.memory | string | `"1Gi"` |  |
| backend.resources.requests.cpu | string | `"500m"` |  |
| backend.resources.requests.memory | string | `"512Mi"` |  |
| worker.enabled | bool | `true` |  |
| worker.image.repository | string | `"kubernetes/hpcgpt/backend"` |  |
| worker.image.tag | string | `"v0.1.1"` |  |
| worker.image.pullPolicy | string | `"Always"` |  |
| worker.replicaCount | int | `1` |  |
| worker.env.QDRANT_COLLECTION_NAME | string | `"{{ include \"osc-chat.name\" . }}"` |  |
| worker.env.S3_BUCKET_NAME | string | `"{{ include \"osc-chat.name\" . }}"` |  |
| worker.resources.limits.cpu | int | `4` |  |
| worker.resources.limits.memory | string | `"2Gi"` |  |
| worker.resources.requests.cpu | int | `2` |  |
| worker.resources.requests.memory | string | `"512Mi"` |  |
| ollama.enabled | bool | `false` |  |
| huggingfaceCache.enabled | bool | `true` |  |
| huggingfaceCache.mountPath | string | `"/var/cache/huggingface"` |  |
| huggingfaceCache.sizeLimit | string | `"5Gi"` |  |
| huggingfaceCache.storageClassName | string | `"{{ .Values.global.storageClass }}"` |  |
| secrets.create | bool | `true` |  |
| secrets.api.openaiKey | string | `"your_strong_key"` |  |
| crawlee.enabled | bool | `true` |  |
| crawlee.image.repository | string | `"kubernetes/hpcgpt/crawlee"` |  |
| crawlee.image.tag | string | `"v0.1.1"` |  |
| crawlee.image.pullPolicy | string | `"Always"` |  |
| crawlee.imagePullSecret.enable | bool | `false` |  |
| crawlee.replicaCount | int | `1` |  |
| crawlee.service.type | string | `"ClusterIP"` |  |
| crawlee.service.port | int | `3000` |  |
| crawlee.env.NO_CRAWL | bool | `false` |  |
| crawlee.env.S3_BUCKET_NAME | string | `"osc-chat"` |  |
| crawlee.env.AWS_REGION | string | `"us-east-1"` |  |
| crawlee.probes.liveness.enabled | bool | `true` |  |
| crawlee.probes.readiness.enabled | bool | `true` |  |
| crawlee.resources.limits.cpu | string | `"1000m"` |  |
| crawlee.resources.limits.memory | string | `"2Gi"` |  |
| crawlee.resources.requests.cpu | string | `"500m"` |  |
| crawlee.resources.requests.memory | string | `"1Gi"` |  |
| keycloak.enabled | bool | `false` |  |
| frontend.enabled | bool | `true` |  |
| frontend.image.repository | string | `"kubernetes/hpcgpt/frontend"` |  |
| frontend.image.tag | string | `"v0.1.4"` |  |
| frontend.image.pullPolicy | string | `"Always"` |  |
| frontend.replicaCount | int | `1` |  |
| frontend.service.type | string | `"ClusterIP"` |  |
| frontend.service.port | int | `3000` |  |
| frontend.ingress.enabled | bool | `true` |  |
| frontend.ingress.className | string | `"nginx"` |  |
| frontend.ingress.annotations."prometheus.io/probe_path" | string | `"/api/healthcheck"` |  |
| frontend.ingress.annotations."prometheus.io/probe_scheme" | string | `"https"` |  |
| frontend.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt"` |  |
| frontend.ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"true"` |  |
| frontend.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` |  |
| frontend.ingress.annotations."nginx.ingress.kubernetes.io/server-alias" | string | `"{{ .Values.global.ingress.hostAlias }}"` |  |
| frontend.ingress.host | string | `"{{ required \"Ingress host must be defined in the global settings\" .Values.global.ingress.host }}"` |  |
| frontend.ingress.tls[0].hosts[0] | string | `"{{ required \"Ingress host must be defined in the global settings\" .Values.global.ingress.host }}"` |  |
| frontend.ingress.tls[0].hosts[1] | string | `"{{ required \"Ingress hostAlias must be defined in the global settings\" .Values.global.ingress.hostAlias }}"` |  |
| frontend.ingress.tls[0].secretName | string | `"osc-chat-frontend"` |  |
| frontend.resources.limits.cpu | string | `"500m"` |  |
| frontend.resources.limits.memory | string | `"512Mi"` |  |
| frontend.resources.requests.cpu | string | `"250m"` |  |
| frontend.resources.requests.memory | string | `"256Mi"` |  |
| networkPolicies.enabled | bool | `false` |  |
| vllm-stack.enabled | bool | `false` |  |
| vllm-stack.servingEngineSpec.labels.release | string | `"osc-chat"` |  |
| vllm-stack.servingEngineSpec.runtimeClassName | string | `""` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].name | string | `"qwen3"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].repository | string | `"docker-registry.osc.edu/kubernetes/vllm/vllm-openai"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].tag | string | `"v0.21.0"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].imagePullSecret | string | `"osc-registry"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].modelURL | string | `"Qwen/Qwen3-8B"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].replicaCount | int | `1` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].enableLoRA | bool | `false` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].requestCPU | int | `4` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].requestMemory | string | `"32Gi"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].requestGPU | int | `1` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].limitCPU | int | `4` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].limitMemory | string | `"32Gi"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].limitGPU | int | `1` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].podAnnotations."prometheus.io/port" | string | `"8000"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].pvcStorage | string | `"50Gi"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].pvcAccessMode[0] | string | `"ReadWriteMany"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].storageClass | string | `"local-ess"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].pvcLabels."osc.edu/service-account" | string | `"oscchat"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].pvcAnnotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.maxModelLen | int | `40960` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.dtype | string | `"half"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[0] | string | `"--disable-access-log-for-endpoints"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[1] | string | `"/health,/metrics,/ping"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[2] | string | `"--gpu-memory-utilization"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[3] | string | `"0.90"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[4] | string | `"--served-model-name"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[5] | string | `"Qwen/Qwen3-8B"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[6] | string | `"--safetensors-load-strategy"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[7] | string | `"eager"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[8] | string | `"--max-num-seqs"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].vllmConfig.extraArgs[9] | string | `"128"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].enableTool | bool | `true` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].toolCallParser | string | `"hermes"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].nodeSelectorTerms[0].matchExpressions[0].key | string | `"nvidia.com/gpu.product"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].nodeSelectorTerms[0].matchExpressions[0].operator | string | `"In"` |  |
| vllm-stack.servingEngineSpec.modelSpec[0].nodeSelectorTerms[0].matchExpressions[0].values[0] | string | `"NVIDIA-A100-PCIE-40GB-MIG-7g.40gb"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].name | string | `"qwen3-embedding"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].repository | string | `"docker-registry.osc.edu/kubernetes/vllm/vllm-openai"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].tag | string | `"v0.21.0"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].imagePullSecret | string | `"osc-registry"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].modelURL | string | `"Qwen/Qwen3-Embedding-8B"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].replicaCount | int | `1` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].enableLoRA | bool | `false` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].requestCPU | int | `4` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].requestMemory | string | `"32Gi"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].requestGPU | int | `1` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].limitCPU | int | `4` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].limitMemory | string | `"32Gi"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].limitGPU | int | `1` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].podAnnotations."prometheus.io/port" | string | `"8000"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].pvcStorage | string | `"50Gi"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].pvcAccessMode[0] | string | `"ReadWriteMany"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].storageClass | string | `"local-ess"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].pvcLabels."osc.edu/service-account" | string | `"oscchat"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].pvcAnnotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.maxModelLen | int | `40960` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.dtype | string | `"half"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[0] | string | `"--disable-access-log-for-endpoints"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[1] | string | `"/health,/metrics,/ping"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[2] | string | `"--gpu-memory-utilization"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[3] | string | `"0.90"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[4] | string | `"--served-model-name"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[5] | string | `"Qwen/Qwen3-Embedding-8B"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[6] | string | `"--safetensors-load-strategy"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[7] | string | `"eager"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[8] | string | `"--max-num-seqs"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].vllmConfig.extraArgs[9] | string | `"128"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].enableTool | bool | `true` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].toolCallParser | string | `"qwen3_coder"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].nodeSelectorTerms[0].matchExpressions[0].key | string | `"nvidia.com/gpu.product"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].nodeSelectorTerms[0].matchExpressions[0].operator | string | `"In"` |  |
| vllm-stack.servingEngineSpec.modelSpec[1].nodeSelectorTerms[0].matchExpressions[0].values[0] | string | `"NVIDIA-A100-PCIE-40GB-MIG-7g.40gb"` |  |
| vllm-stack.servingEngineSpec.vllmApiKey.secretName | string | `"osc-chat-app-secrets"` |  |
| vllm-stack.servingEngineSpec.vllmApiKey.secretKey | string | `"OPENAI_API_KEY"` |  |
| vllm-stack.servingEngineSpec.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| vllm-stack.servingEngineSpec.env[0].name | string | `"USER"` |  |
| vllm-stack.servingEngineSpec.env[0].value | string | `"skhuvis"` |  |
| vllm-stack.servingEngineSpec.env[1].name | string | `"LOGNAME"` |  |
| vllm-stack.servingEngineSpec.env[1].value | string | `"skhuvis"` |  |
| vllm-stack.servingEngineSpec.env[2].name | string | `"VLLM_CACHE_ROOT"` |  |
| vllm-stack.servingEngineSpec.env[2].value | string | `"/data/vllm_cache"` |  |
| vllm-stack.servingEngineSpec.env[3].name | string | `"FLASHINFER_WORKSPACE_BASE"` |  |
| vllm-stack.servingEngineSpec.env[3].value | string | `"/data/flashinfer"` |  |
| vllm-stack.servingEngineSpec.env[4].name | string | `"TRITON_CACHE_DIR"` |  |
| vllm-stack.servingEngineSpec.env[4].value | string | `"/data/triton"` |  |
| vllm-stack.servingEngineSpec.env[5].name | string | `"VLLM_NO_USAGE_STATS"` |  |
| vllm-stack.servingEngineSpec.env[5].value | string | `"1"` |  |
| vllm-stack.servingEngineSpec.env[6].name | string | `"DO_NOT_TRACK"` |  |
| vllm-stack.servingEngineSpec.env[6].value | string | `"1"` |  |
| vllm-stack.servingEngineSpec.env[7].name | string | `"OMP_NUM_THREADS"` |  |
| vllm-stack.servingEngineSpec.env[7].value | string | `"2"` |  |
| vllm-stack.routerSpec.enableRouter | bool | `true` |  |
| vllm-stack.routerSpec.repository | string | `"docker-registry.osc.edu/kubernetes/lmcache/lmstack-router"` |  |
| vllm-stack.routerSpec.tag | string | `"v0.1.11"` |  |
| vllm-stack.routerSpec.imagePullPolicy | string | `"IfNotPresent"` |  |
| vllm-stack.routerSpec.imagePullSecrets[0].name | string | `"osc-registry"` |  |
| vllm-stack.routerSpec.env[0].name | string | `"USER"` |  |
| vllm-stack.routerSpec.env[0].value | string | `"osc-chat"` |  |
| vllm-stack.routerSpec.env[1].name | string | `"LOGNAME"` |  |
| vllm-stack.routerSpec.env[1].value | string | `"osc-chat"` |  |
| vllm-stack.routerSpec.servicePort | int | `80` |  |
| vllm-stack.routerSpec.labels.environment | string | `nil` |  |
| vllm-stack.routerSpec.labels.release | string | `"osc-chat"` |  |
| vllm-stack.routerSpec.labels."osc.edu/service-account" | string | `"oscchat"` |  |
| vllm-stack.routerSpec.serviceAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| vllm-stack.routerSpec.serviceAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| vllm-stack.routerSpec.serviceAnnotations."prometheus.io/port" | string | `"80"` |  |
| vllm-stack.routerSpec.resources.requests.cpu | int | `4` |  |
| vllm-stack.routerSpec.resources.requests.memory | string | `"1500Mi"` |  |
| vllm-stack.routerSpec.resources.limits.cpu | int | `4` |  |
| vllm-stack.routerSpec.resources.limits.memory | string | `"4000Mi"` |  |
| vllm-stack.routerSpec.ingress.enabled | bool | `true` |  |
| vllm-stack.routerSpec.ingress.className | string | `"nginx"` |  |
| vllm-stack.routerSpec.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt"` |  |
| vllm-stack.routerSpec.ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"true"` |  |
| vllm-stack.routerSpec.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` |  |
| vllm-stack.routerSpec.ingress.annotations."nginx.ingress.kubernetes.io/whitelist-source-range" | string | `"131.187.45.7,192.148.247.0/24,10.0.0.0/8"` |  |
| vllm-stack.routerSpec.ingress.hosts[0].host | string | `"oscchat-test-vllm.k8.osc.edu"` |  |
| vllm-stack.routerSpec.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| vllm-stack.routerSpec.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| vllm-stack.routerSpec.ingress.tls[0].secretName | string | `"osc-chat-vllm"` |  |
| vllm-stack.routerSpec.ingress.tls[0].hosts[0] | string | `"oscchat-test-vllm.k8.osc.edu"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
