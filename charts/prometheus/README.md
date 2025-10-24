# prometheus

![Version: 0.18.5](https://img.shields.io/badge/Version-0.18.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.44.0](https://img.shields.io/badge/AppVersion-v2.44.0-informational?style=flat-square)

OSC Prometheus deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://nvidia.github.io/dcgm-exporter/helm-charts | dcgm-exporter | 2.6.5 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.5.0 |
| https://prometheus-community.github.io/helm-charts/ | kube-state-metrics | 5.6.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imagePullSecret.name | string | `"osc-registry"` |  |
| global.imagePullSecret.registry | string | `"docker-registry.osc.edu"` |  |
| global.imagePullSecret.username | string | `"robot$osc-read"` |  |
| global.imagePullSecret.password | string | `nil` |  |
| image.repository | string | `"quay.io/prometheus/prometheus"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `""` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.name | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `94` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `94` |  |
| securityContext.runAsGroup | int | `94` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `9090` |  |
| service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| service.annotations."prometheus.io/path" | string | `"/metrics"` |  |
| service.annotations."prometheus.io/probe_module" | string | `"http-healthz"` |  |
| service.annotations."prometheus.io/probe_path" | string | `"/-/healthy"` |  |
| resources | object | `{}` |  |
| dnsDomain | string | `"cluster.local"` |  |
| config.name | string | `"prometheus.yaml"` |  |
| storageClassName | string | `nil` |  |
| watch.image.repository | string | `"docker-registry.osc.edu/kubernetes/weaveworks/watch"` |  |
| watch.image.tag | string | `"master-5fc29a9"` |  |
| watch.image.pullPolicy | string | `"IfNotPresent"` |  |
| watch.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| watch.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| watch.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| watch.securityContext.privileged | bool | `false` |  |
| watch.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| watch.securityContext.runAsNonRoot | bool | `true` |  |
| watch.securityContext.runAsUser | int | `94` |  |
| watch.securityContext.runAsGroup | int | `94` |  |
| watch.resources.limits.memory | string | `"128Mi"` |  |
| watch.resources.requests.cpu | string | `"100m"` |  |
| watch.resources.requests.memory | string | `"50Mi"` |  |
| proxy.oidcIssuerURL | string | `nil` |  |
| proxy.clientID | string | `nil` |  |
| proxy.clientSecret | string | `nil` |  |
| proxy.cookieSecret | string | `nil` |  |
| proxy.cookieName | string | `nil` |  |
| proxy.allowGroups | string | `nil` |  |
| proxy.name | string | `"prometheus-proxy"` |  |
| proxy.image.repository | string | `"quay.io/oauth2-proxy/oauth2-proxy"` |  |
| proxy.image.pullPolicy | string | `"IfNotPresent"` |  |
| proxy.image.tag | string | `"v7.4.0"` |  |
| proxy.securityContext | object | `{}` |  |
| proxy.resources | object | `{}` |  |
| proxy.service.type | string | `"ClusterIP"` |  |
| proxy.service.port | int | `4180` |  |
| proxy.service.annotations."prometheus.io/probe_module" | string | `"http-healthz"` |  |
| proxy.service.annotations."prometheus.io/probe_path" | string | `"/ping"` |  |
| proxy.metricsService.type | string | `"ClusterIP"` |  |
| proxy.metricsService.port | int | `8080` |  |
| proxy.metricsService.annotations."prometheus.io/scrape" | string | `"true"` |  |
| proxy.metricsService.annotations."prometheus.io/path" | string | `"/metrics"` |  |
| proxy.ingress.className | string | `"nginx"` |  |
| proxy.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"8k"` |  |
| proxy.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt"` |  |
| proxy.ingress.annotations."prometheus.io/probe_path" | string | `"/ping"` |  |
| proxy.ingress.host | string | `"prometheus-proxy.local"` |  |
| proxy.ingress.hostAlias | string | `nil` |  |
| blackboxExporter.name | string | `"blackbox-exporter"` |  |
| blackboxExporter.configName | string | `"blackbox-exporter-config"` |  |
| blackboxExporter.image.repository | string | `"quay.io/prometheus/blackbox-exporter"` |  |
| blackboxExporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| blackboxExporter.image.tag | string | `"v0.24.0"` |  |
| blackboxExporter.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| blackboxExporter.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| blackboxExporter.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| blackboxExporter.securityContext.privileged | bool | `false` |  |
| blackboxExporter.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| blackboxExporter.securityContext.runAsNonRoot | bool | `true` |  |
| blackboxExporter.securityContext.runAsUser | int | `65534` |  |
| blackboxExporter.securityContext.runAsGroup | int | `65534` |  |
| blackboxExporter.resources.limits.memory | string | `"128Mi"` |  |
| blackboxExporter.resources.requests.cpu | string | `"100m"` |  |
| blackboxExporter.resources.requests.memory | string | `"50Mi"` |  |
| blackboxExporter.service.type | string | `"ClusterIP"` |  |
| blackboxExporter.service.port | int | `9115` |  |
| blackboxExporter.service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| blackboxExporter.service.annotations."prometheus.io/path" | string | `"/metrics"` |  |
| sslExporter.name | string | `"ssl-exporter"` |  |
| sslExporter.configName | string | `"ssl-exporter-config"` |  |
| sslExporter.rbac.create | bool | `false` |  |
| sslExporter.image.repository | string | `"docker-registry.osc.edu/kubernetes/ribbybibby/ssl-exporter"` |  |
| sslExporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| sslExporter.image.tag | string | `"2.4.2"` |  |
| sslExporter.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| sslExporter.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| sslExporter.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| sslExporter.securityContext.privileged | bool | `false` |  |
| sslExporter.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| sslExporter.securityContext.runAsNonRoot | bool | `true` |  |
| sslExporter.securityContext.runAsUser | int | `65534` |  |
| sslExporter.securityContext.runAsGroup | int | `65534` |  |
| sslExporter.resources.limits.memory | string | `"128Mi"` |  |
| sslExporter.resources.requests.cpu | string | `"100m"` |  |
| sslExporter.resources.requests.memory | string | `"50Mi"` |  |
| sslExporter.service.type | string | `"ClusterIP"` |  |
| sslExporter.service.port | int | `9219` |  |
| sslExporter.service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| sslExporter.service.annotations."prometheus.io/path" | string | `"/metrics"` |  |
| ingressName | string | `"ingress-nginx"` |  |
| namespaceReaper | string | `"k8-namespace-reaper"` |  |
| kube-state-metrics.nameOverride | string | `"kube-state-metrics"` |  |
| kube-state-metrics.fullnameOverride | string | `"kube-state-metrics"` |  |
| kube-state-metrics.prometheusScrape | bool | `false` |  |
| kube-state-metrics.service.annotations."prometheus.io/probe_skip" | string | `"true"` |  |
| kube-state-metrics.collectors | list | `[]` |  |
| kube-state-metrics.selfMonitor.enabled | bool | `true` |  |
| kube-state-metrics.selfMonitor.telemetryPort | int | `8081` |  |
| kube-state-metrics.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| kube-state-metrics.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| kube-state-metrics.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| kube-state-metrics.containerSecurityContext.privileged | bool | `false` |  |
| kube-state-metrics.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| dcgm-exporter.nameOverride | string | `"dcgm-exporter"` |  |
| dcgm-exporter.fullnameOverride | string | `"dcgm-exporter"` |  |
| dcgm-exporter.arguments[0] | string | `"--no-hostname"` |  |
| dcgm-exporter.extraEnv[0].name | string | `"__DCGM_DBG_LVL"` |  |
| dcgm-exporter.extraEnv[0].value | string | `"NONE"` |  |
| dcgm-exporter.podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| dcgm-exporter.podAnnotations."prometheus.io/port" | string | `"9400"` |  |
| dcgm-exporter.service.enable | bool | `false` |  |
| dcgm-exporter.service.port | int | `9400` |  |
| dcgm-exporter.serviceMonitor.enabled | bool | `false` |  |
| dcgm-exporter.resources.limits.cpu | string | `"1"` |  |
| dcgm-exporter.resources.limits.memory | string | `"256Mi"` |  |
| dcgm-exporter.resources.requests.cpu | string | `"0.5"` |  |
| dcgm-exporter.resources.requests.memory | string | `"128Mi"` |  |
| dcgm-exporter.nodeSelector."feature.node.kubernetes.io/pci-10de.present" | string | `"true"` |  |
| replicaCount | int | `1` |  |
| nodeSelector."kubernetes.io/os" | string | `"linux"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
