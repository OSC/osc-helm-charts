# osc-open-webui

![Version: 0.5.1](https://img.shields.io/badge/Version-0.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC Open Web UI deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.openwebui.com/ | open-webui | 12.3.0 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.9.0 |

## Usage

Define necessary values:

```yaml
global:
  oscServiceAccount: testuser
  imagePullSecret:
    password: SECRET
  ingress:
    host: testuser.k8.osc.edu
    hostAlias: testuser.osc.edu
  auth:
    idpHost: IDP
    clientID: client-id
    clientSecret: client-secret
    cookieSecret: secret
    allowGroups:
      - group
  alert:
    receiver:
  maintenanceGroups:
    - group
  webui_secret_key: SECRET

open-webui:
  podLabels:
    osc.edu/service-account: testuser
  nodeSelector:
    node-role.kubernetes.io/webservices: ''
  ollama:
    nodeSelector:
      nvidia.com/gpu.product: NVIDIA-A100-PCIE-40GB-MIG-7g.40gb
      node-role.kubernetes.io/webservices: ''
    deployment:
      labels:
        osc.edu/service-account: testuser
    podLabels:
      osc.edu/service-account: testuser
    extraEnvVars:
      - name: CONFIG_ITEM
        value: "False"
    volumes:
      - name: data
        hostPath:
          path: /fs/ess/PROJECT
          type: Directory
      - name: home
        hostPath:
          path: /users/PROJECT/USER
          type: Directory
```

Below is an example of PAAS usage:

```yaml
---
global:
  imagePullSecret:
    create: false
  ingress:
    host: <USERNAME>.k8.osc.edu
    annotations:
      # Limit to OH-TECH VPN
      nginx.ingress.kubernetes.io/whitelist-source-range: '<OH-TECH VPN>'
  # Generate from the command 'uuidgen'
  webui_secret_key: <SECRET>
auth:
  enable: false
open-webui:
  persistence:
    storageClass: paas-nfs-client
  sso:
    enabled: false
  ollama:
    ollama:
      models:
        pull:
          - <model to pull>
        run:
          - <model to pull>
    nodeSelector:
      # Set MIG
      # One of
      # - NVIDIA-A100-PCIE-40GB-MIG-1g.5gb
      # - NVIDIA-A100-PCIE-40GB-MIG-3g.20gb
      # - NVIDIA-A100-PCIE-40GB-MIG-7g.40gb
      nvidia.com/gpu.product: <MIG>
    volumes:
      - name: data
        hostPath:
          path: /fs/scratch/<Primary group>/<Username>
          type: Directory
      - name: home
        hostPath:
          path: /users/<Primary group>/<Username>
          type: Directory
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.oscServiceAccount | The service account used by OSC deployments. Also pulled from global.env.<env>.serviceAccount | `""` |
| global.environment | The deployment's OSC environment | `"production"` |
| global.nodeSelectorRole | The nodeSelector role | `"webservices"` |
| global.imagePullSecret.create | Create the image pull secret | `true` |
| global.imagePullSecret.name | image pull secret name | `"osc-registry"` |
| global.imagePullSecret.registry | OSC registry address | `"docker-registry.osc.edu"` |
| global.imagePullSecret.password | The image pull secret password for database images | **required** |
| global.networkPolicy.create | Create the network policy | `false` |
| global.networkPolicy.podSelector | Labels for NetworkPolicy podSelector. Defaults to `"osc.common.selectorLabels"` | `nil` |
| global.networkPolicy.ingressAllowedPods | Labels of pods allowed to Ingress from the same namespace | `[]` |
| global.debugGroups | Groups that debug pods | `[]` |
| global.maintenanceGroups | Groups that can perform maintenance operations | `[]` |
| global.portforwardGroups | Groups that are allowed to perform port forwarding | `[]` |
| global.webservicesDeploy.create | Create webservices deployment rolebinding | `true` |
| global.ingress.host |  | `""` |
| global.ingress.hostAlias |  | `""` |
| global.ingress.annotations | Additional Ingress annotations | `nil` |
| global.auth.idpHost |  | `nil` |
| global.auth.clientID |  | `nil` |
| global.auth.clientSecret |  | `nil` |
| global.auth.cookieSecret |  | `nil` |
| global.auth.allowGroups |  | `[]` |
| global.alert.receiver |  | `nil` |
| global.webui_secret_key |  | `nil` |
| ingressName |  | `"ingress-nginx"` |
| prometheusName |  | `"prometheus"` |
| auth.enable |  | `true` |
| auth.cookieName |  | `"_{{ include \"osc.common.serviceAccountValue\" . }}{{ include \"osc.common.environment\" . }}"` |
| auth.oidcIssuerURL |  | `"https://$(IDP_HOST)/realms/osc"` |
| auth.image.repository |  | `"quay.io/oauth2-proxy/oauth2-proxy"` |
| auth.image.tag |  | `"v7.1.3"` |
| auth.image.pullPolicy |  | `"IfNotPresent"` |
| auth.podSecurityContext.runAsNonRoot |  | `true` |
| auth.service.port |  | `4180` |
| auth.service.annotations."prometheus.io/probe_module" |  | `"http-healthz"` |
| auth.service.annotations."prometheus.io/probe_path" |  | `"/ping"` |
| auth.metricsService.type |  | `"ClusterIP"` |
| auth.metricsService.port |  | `8080` |
| auth.metricsService.annotations."prometheus.io/scrape" |  | `"true"` |
| auth.metricsService.annotations."prometheus.io/path" |  | `"/metrics"` |
| auth.podResources.limits.cpu |  | `"200m"` |
| auth.podResources.limits.memory |  | `"128Mi"` |
| auth.podResources.requests.cpu |  | `"100m"` |
| auth.podResources.requests.memory |  | `"64Mi"` |
| auth.replicas |  | `1` |
| auth.podDistributionBudget.minAvailable |  | `1` |
| open-webui.nameOverride |  | `"open-webui"` |
| open-webui.fullnameOverride | Set to force old names after upgrades | `"open-webui"` |
| open-webui.serviceAccount.name | Set to force old names after upgrades | `"open-webui"` |
| open-webui.openaiApiKey |  | `false` |
| open-webui.pipelines.enabled |  | `false` |
| open-webui.websocket.enabled |  | `false` |
| open-webui.podLabels |  | `{}` |
| open-webui.image.repository |  | `"docker-registry.osc.edu/kubernetes/open-webui/open-webui"` |
| open-webui.image.tag |  | `"0.8.2"` |
| open-webui.imagePullSecrets[0].name |  | `"osc-registry"` |
| open-webui.resources.limits.memory |  | `"4Gi"` |
| open-webui.resources.limits.cpu |  | `2` |
| open-webui.resources.requests.memory |  | `"2Gi"` |
| open-webui.resources.requests.cpu |  | `1` |
| open-webui.copyAppData.resources.limits.memory |  | `"1Gi"` |
| open-webui.copyAppData.resources.limits.cpu |  | `1` |
| open-webui.copyAppData.resources.requests.memory |  | `"500Mi"` |
| open-webui.copyAppData.resources.requests.cpu |  | `"500m"` |
| open-webui.ingress.enabled |  | `false` |
| open-webui.persistence.size |  | `"10Gi"` |
| open-webui.persistence.storageClass |  | `"webservices-nfs-client"` |
| open-webui.nodeSelector |  | `{}` |
| open-webui.extraEnvVars |  | `[]` |
| open-webui.commonEnvVars[0].name |  | `"WEBUI_AUTH_TRUSTED_GROUPS_HEADER"` |
| open-webui.commonEnvVars[0].value |  | `"X-Auth-Request-Groups"` |
| open-webui.commonEnvVars[1].name |  | `"ENABLE_OAUTH_GROUP_CREATION"` |
| open-webui.commonEnvVars[1].value |  | `"True"` |
| open-webui.commonEnvVars[2].name |  | `"DEFAULT_USER_ROLE"` |
| open-webui.commonEnvVars[2].value |  | `"user"` |
| open-webui.commonEnvVars[3].name |  | `"ENABLE_SIGNUP"` |
| open-webui.commonEnvVars[3].value |  | `"True"` |
| open-webui.commonEnvVars[4].name |  | `"ENABLE_OAUTH_SIGNUP"` |
| open-webui.commonEnvVars[4].value |  | `"False"` |
| open-webui.commonEnvVars[5].name |  | `"ENABLE_LOGIN_FORM"` |
| open-webui.commonEnvVars[5].value |  | `"True"` |
| open-webui.commonEnvVars[6].name |  | `"WEBUI_AUTH"` |
| open-webui.commonEnvVars[6].value |  | `"True"` |
| open-webui.commonEnvVars[7].name |  | `"ENABLE_VERSION_UPDATE_CHECK"` |
| open-webui.commonEnvVars[7].value |  | `"False"` |
| open-webui.commonEnvVars[8].name |  | `"ENABLE_API_KEYS"` |
| open-webui.commonEnvVars[8].value |  | `"True"` |
| open-webui.extraEnvFrom[0].secretRef.name |  | `"osc-open-webui-secret"` |
| open-webui.service.port |  | `80` |
| open-webui.service.annotations."prometheus.io/probe_module" |  | `"http"` |
| open-webui.service.annotations."prometheus.io/probe_scheme" |  | `"http"` |
| open-webui.podSecurityContext.runAsNonRoot |  | `true` |
| open-webui.containerSecurityContext.allowPrivilegeEscalation |  | `false` |
| open-webui.containerSecurityContext.capabilities.drop[0] |  | `"ALL"` |
| open-webui.containerSecurityContext.seccompProfile.type |  | `"RuntimeDefault"` |
| open-webui.containerSecurityContext.privileged |  | `false` |
| open-webui.sso.enabled |  | `true` |
| open-webui.sso.trustedHeader.enabled |  | `true` |
| open-webui.sso.trustedHeader.nameHeader |  | `"X-Auth-Request-Preferred-Username"` |
| open-webui.sso.trustedHeader.emailHeader |  | `"X-Auth-Request-Email"` |
| open-webui.ollama.fullnameOverride |  | `"open-webui-ollama"` |
| open-webui.ollama.image.repository |  | `"docker-registry.osc.edu/kubernetes/ollama/ollama"` |
| open-webui.ollama.image.tag |  | `"0.16.1"` |
| open-webui.ollama.imagePullSecrets[0].name |  | `"osc-registry"` |
| open-webui.ollama.ollama.gpu.enabled |  | `true` |
| open-webui.ollama.ollama.gpu.type |  | `"nvidia"` |
| open-webui.ollama.ollama.gpu.number |  | `1` |
| open-webui.ollama.nodeSelector |  | `{}` |
| open-webui.ollama.service.annotations."prometheus.io/probe_module" |  | `"http"` |
| open-webui.ollama.service.annotations."prometheus.io/probe_scheme" |  | `"http"` |
| open-webui.ollama.deployment.labels |  | `{}` |
| open-webui.ollama.podLabels |  | `{}` |
| open-webui.ollama.podSecurityContext.runAsNonRoot |  | `true` |
| open-webui.ollama.securityContext.allowPrivilegeEscalation |  | `false` |
| open-webui.ollama.securityContext.capabilities.drop[0] |  | `"ALL"` |
| open-webui.ollama.securityContext.seccompProfile.type |  | `"RuntimeDefault"` |
| open-webui.ollama.securityContext.privileged |  | `false` |
| open-webui.ollama.resources.limits.memory |  | `"8Gi"` |
| open-webui.ollama.resources.limits.cpu |  | `4` |
| open-webui.ollama.resources.requests.memory |  | `"4Gi"` |
| open-webui.ollama.resources.requests.cpu |  | `2` |
| open-webui.ollama.volumes |  | `[]` |
| open-webui.ollama.volumeMounts[0].name |  | `"data"` |
| open-webui.ollama.volumeMounts[0].mountPath |  | `"/data"` |
| open-webui.ollama.volumeMounts[0].subPath |  | `"ollama-models"` |
| open-webui.ollama.volumeMounts[1].name |  | `"home"` |
| open-webui.ollama.volumeMounts[1].mountPath |  | `"/home/ollama"` |
| open-webui.ollama.volumeMounts[1].subPath |  | `"ollama-home"` |
| open-webui.ollama.extraEnv[0].name |  | `"OLLAMA_MODELS"` |
| open-webui.ollama.extraEnv[0].value |  | `"/data"` |
| open-webui.ollama.extraEnv[1].name |  | `"HOME"` |
| open-webui.ollama.extraEnv[1].value |  | `"/home/ollama"` |
| open-webui.ollama.extraEnv[2].name |  | `"OLLAMA_FLASH_ATTENTION"` |
| open-webui.ollama.extraEnv[2].value |  | `"1"` |
