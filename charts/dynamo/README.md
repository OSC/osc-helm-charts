# dynamo

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.2.0-cuda13](https://img.shields.io/badge/AppVersion-1.2.0--cuda13-informational?style=flat-square)

A Helm chart to deploy Dynamo resources at OSC

## dynamo Chart

This chart handles the deployment of Dynamo resources.  It depends on the Dynamo platform and operator being deployed.

Components:

* image-puller
    * A daemonset that pulls the Dynamo images and sleeps to ensure those images are on all nodes
* Items to support Dynamo
    * PVC for cache storage
    * Huggingface secret
* Dynamo frontend
* Open WebUI

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
  webui_secret_key: <Open WebUI webui secret>
  models:
    qwen3:
      model: Qwen/Qwen3-0.6B
      # image: ...
      # pullPolicy: ...
      disagg: true
      kvRouting: true
      scaling:
        minReplicas: 0
        maxReplicas: 2
        cooldownPeriod: 600
      args:
        - --max-model-len
        - "20480"
      # frontend:
      #   image: ...
      #   pullPolicy: ...
      #   env: []
      #   args: []
      #   cpu: 1
      #   memory: 2Gi
      decode:
        # scaling:
        #   minReplicas: 0
        #   maxReplicas: 2
        #   cooldownPeriod: 600
        # image: ...
        # pullPolicy: ...
        args: []
        cpu: 2
        memory: 6Gi
        gpu: 1
        gpuType: NVIDIA-A100-PCIE-40GB-MIG-1g.5gb
        nodes: 1
      prefill:
        # scaling:
        #   minReplicas: 0
        #   maxReplicas: 2
        #   cooldownPeriod: 600
        # image: ...
        # pullPolicy: ...
        args: []
        cpu: 2
        memory: 6Gi
        gpu: 1
        gpuType: NVIDIA-A100-PCIE-40GB-MIG-1g.5gb
        nodes: 1
hfToken:
  value: <Huggingface token>
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.14.2 |
| https://osc.github.io/osc-helm-charts/ | osc-open-webui | 0.7.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.oscServiceAccount | string | `"dynamo"` | The service account used by OSC deployments. |
| global.environment | string | `"production"` | The deployment's OSC environment |
| global.nodeSelectorRole | string | `"webservices"` | The OSC node role to use with nodeSelector |
| global.imagePullSecret.name | string | `"osc-registry"` | imagePullSecret name |
| global.imagePullSecret.registry | string | `"docker-registry.osc.edu"` | imagePullSecret registry |
| global.imagePullSecret.username | string | `"robot$webservices-read"` | imagePullSecret username |
| global.imagePullSecret.password | string | **required** | imagePullSecret password. This value will be set by OSC's Puppet. |
| global.fileset | string | `"PZS0645"` | The fileset for storage |
| global.storageClass | string | `"local-ess"` | The storage class to use for PV claims |
| global.ingress.host | string | `""` | Ingress host name |
| global.ingress.hostAlias | string | `""` | Ingress host alias |
| global.auth.allowGroups | list | `["oscall","PZS0645","PZS0580"]` | Restrict access to these groups |
| global.webui_secret_key | string | **required** | The Open WebUI secret key |
| global.models | object | `{}` | Define models |
| image.repository | string | `"kubernetes/ai-dynamo/vllm-runtime"` | The repository path to main vllm runtime image |
| image.tag | string | The chart's appVersion | The vllm runtime image tag |
| image.release | string | `"0"` | The release of the custom OSC vllm runtime image |
| hfToken.value | string | **required** | The HF token for Hugging Face |
| cache | object | `{}` |  |
| networkPolicy.namespaceSelectors | list | `[]` | Namespace labels to allow access to frontends |
| defaultGpuType | string | `"NVIDIA-A100-PCIE-40GB-MIG-7g.40gb"` | The default GPU type |
| rdmaResource | string | `"rdma/shared_mlx5"` | The RDMA resource name in Kubernetes |
| prometheusURL | string | `"http://prometheus-prometheus.prometheus.svc:9090"` | The Prometheus URL |
| priorityClassName | string | `""` | The priority class name for frontend and workers |
| workerArgs | list | `[]` | Additional worker arguments |
| kvTransferConfig | object | `{"kv_connector":"NixlConnector","kv_role":"kv_both"}` | The configuration of kv-transfer-config |
| kvEventsConfig | object | `{"enable_kv_cache_events":true,"endpoint":"tcp://*:20080","publisher":"zmq","topic":"kv-events"}` | The configuration for kv-events-config |
| osc-open-webui.open-webui.image.tag | string | `"0.9.6"` | The version of Open WebUI |
| osc-open-webui.open-webui.sso.enableRoleManagement | bool | `true` | Enables role access controls in Open WebUI |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
