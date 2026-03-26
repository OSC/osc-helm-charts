# osc-open-webui

![Version: 0.6.0](https://img.shields.io/badge/Version-0.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC Open Web UI deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.10.1 |
| oci://docker-registry.osc.edu/kubernetes/open-webui | open-webui | 12.10.0-osc-r1 |

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
  sso:
    enableRoleManagement: true
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
  oscServiceAccount: <USERNAME>
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
| global.ingress.host | Ingress host | **required** |
| global.ingress.hostAlias | Ingress host alias | **required** |
| global.ingress.annotations | Additional Ingress annotations for the Ingress resource | `nil` |
| global.auth.allowGroups | Restrict access to these groups | `[]` |
| global.alert.receiver | The alert receiver | `nil` |
| global.webui_secret_key |  | `nil` |
| ollama.networkPolicy.allowedPodLabels | Array of additional pod labels to allow | `[]` |
| open-webui.image.repository | OSC registry location for Open WebUI image | `"docker-registry.osc.edu/kubernetes/open-webui/open-webui"` |
| open-webui.image.tag | The Open WebUI image tag.  Must be synced to OSC registry | `"0.8.11"` |
| open-webui.resources.limits.memory | Open WebUI pod memory limit | `"4Gi"` |
| open-webui.resources.limits.cpu | Open WebUI pod CPU limit | `2` |
| open-webui.resources.requests.memory | Open WebUI pod memory request | `"2Gi"` |
| open-webui.resources.requests.cpu | Open WebUI pod CPU request | `1` |
| open-webui.persistence.storageClass | The Open WebUI persistent storage class | `"webservices-nfs-client"` |
| open-webui.extraEnvVars | Additional Open WebUI environment variables | `[]` |
| open-webui.sso.enableRoleManagement | Enables role access controls in Open WebUI | `false` |
| open-webui.ollama.nameOverride |  | `"ollama"` |
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
| open-webui.ollama.resources.limits.memory |  | `"16Gi"` |
| open-webui.ollama.resources.limits.cpu |  | `8` |
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
