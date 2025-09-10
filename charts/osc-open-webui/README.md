# osc-open-webui

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC Open Web UI deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://helm.openwebui.com/ | open-webui | 8.4.0 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.7.0 |

## Usage

Define necessary values:

```
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
  maintenance:
    groups:
  webui_secret_key: SECRET

open-webui:
  podLabels:
    osc.edu/service-account: testuser
  nodeSelector:
    node-role.kubernetes.io/webservices: ''
  sso:
    oidc:
      clientId: client-id
      clientSecret: client-secret
      providerUrl: https://IDP/realms/osc/.well-known/openid-configuration
  ollama:
    nodeSelector:
      nvidia.com/gpu.product: NVIDIA-A100-PCIE-40GB-MIG-7g.40gb
      node-role.kubernetes.io/webservices: ''
    deployment:
      labels:
        osc.edu/service-account: testuser
    podLabels:
      osc.edu/service-account: testuser
    volumes:
      - name: data
        hostPath:
          path: /fs/ess/PROJECT/ollama-models
          type: Directory
      - name: home
        hostPath:
          path: /users/PROJECT/USER/ollama-home
          type: Directory
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.oscServiceAccount |  | `nil` |
| global.imagePullSecret.name |  | `"osc-registry"` |
| global.imagePullSecret.registry |  | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username |  | `"robot$webservices-read"` |
| global.imagePullSecret.password |  | `nil` |
| global.nodeSelectorRole |  | `"webservices"` |
| global.ingress.host |  | `""` |
| global.ingress.hostAlias |  | `""` |
| global.auth.idpHost |  | `nil` |
| global.auth.clientID |  | `nil` |
| global.auth.clientSecret |  | `nil` |
| global.auth.cookieSecret |  | `nil` |
| global.auth.allowGroups |  | `nil` |
| global.alert.receiver |  | `nil` |
| global.maintenance.groups |  | `nil` |
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
| open-webui.pipelines.enabled |  | `false` |
| open-webui.podLabels |  | `{}` |
| open-webui.image | Example service account label osc.edu/service-account: TODO | `{"repository":"docker-registry.osc.edu/kubernetes/open-webui/open-webui","tag":"0.6.28"}` |
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
| open-webui.extraEnvVars | Example node selector nodeSelector:   node-role.kubernetes.io/webservices: '' | `[{"name":"ENABLE_OAUTH_GROUP_CREATION","value":"True"},{"name":"WEBUI_SECRET_KEY","valueFrom":{"secretKeyRef":{"key":"webui_secret_key","name":"osc-open-webui-secret"}}}]` |
| open-webui.service.port |  | `80` |
| open-webui.service.annotations."prometheus.io/probe_module" |  | `"http"` |
| open-webui.service.annotations."prometheus.io/probe_scheme" |  | `"http"` |
| open-webui.podSecurityContext.runAsNonRoot |  | `true` |
| open-webui.containerSecurityContext.allowPrivilegeEscalation |  | `false` |
| open-webui.containerSecurityContext.capabilities.drop[0] |  | `"ALL"` |
| open-webui.containerSecurityContext.seccompProfile.type |  | `"RuntimeDefault"` |
| open-webui.containerSecurityContext.privileged |  | `false` |
| open-webui.sso.enabled |  | `true` |
| open-webui.sso.enableSignup |  | `true` |
| open-webui.sso.enableGroupManagement |  | `true` |
| open-webui.sso.oidc.enabled |  | `true` |
| open-webui.sso.oidc.clientId |  | `nil` |
| open-webui.sso.oidc.clientSecret |  | `nil` |
| open-webui.sso.oidc.providerUrl |  | `nil` |
| open-webui.sso.oidc.scopes | Example provider URL providerUrl: http://keycloak.example.com/realms/master/.well-known/openid-configuration | `"openid email profile groups"` |
| open-webui.ollama.image.repository |  | `"docker-registry.osc.edu/kubernetes/ollama/ollama"` |
| open-webui.ollama.image.tag |  | `"0.11.7"` |
| open-webui.ollama.imagePullSecrets[0].name |  | `"osc-registry"` |
| open-webui.ollama.gpu.enabled |  | `true` |
| open-webui.ollama.gpu.type |  | `"nvidia"` |
| open-webui.ollama.gpu.number |  | `1` |
| open-webui.ollama.nodeSelector |  | `{}` |
| open-webui.ollama.service | Example using MIG product nodeSelector:   nvidia.com/gpu.product: NVIDIA-A100-PCIE-40GB-MIG-7g.40gb   node-role.kubernetes.io/webservices: '' | `{"annotations":{"prometheus.io/probe_module":"http","prometheus.io/probe_scheme":"http"}}` |
| open-webui.ollama.deployment.labels |  | `{}` |
| open-webui.ollama.podLabels |  | `{}` |
| open-webui.ollama.podSecurityContext | Example labels podLabels:   osc.edu/service-account: TODO | `{"runAsNonRoot":true}` |
| open-webui.ollama.securityContext.allowPrivilegeEscalation |  | `false` |
| open-webui.ollama.securityContext.capabilities.drop[0] |  | `"ALL"` |
| open-webui.ollama.securityContext.seccompProfile.type |  | `"RuntimeDefault"` |
| open-webui.ollama.securityContext.privileged |  | `false` |
| open-webui.ollama.resources.limits.memory |  | `"8Gi"` |
| open-webui.ollama.resources.limits.cpu |  | `4` |
| open-webui.ollama.resources.requests.memory |  | `"4Gi"` |
| open-webui.ollama.resources.requests.cpu |  | `2` |
| open-webui.ollama.volumes |  | `[]` |
| open-webui.ollama.volumeMounts | Example ESS mount volumes: - name: data   hostPath:     path: /fs/ess/TODO/ollama-models     type: Directory - name: home   hostPath:     path: /users/PROJECT/USER     type: Directory | `[{"mountPath":"/data","name":"data"},{"mountPath":"/home/ollama","name":"home"}]` |
| open-webui.ollama.extraEnv[0].name |  | `"OLLAMA_MODELS"` |
| open-webui.ollama.extraEnv[0].value |  | `"/data"` |
| open-webui.ollama.extraEnv[1].name |  | `"HOME"` |
| open-webui.ollama.extraEnv[1].value |  | `"/home/ollama"` |
