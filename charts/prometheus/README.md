# prometheus

![Version: 0.22.1](https://img.shields.io/badge/Version-0.22.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.11.3](https://img.shields.io/badge/AppVersion-v3.11.3-informational?style=flat-square)

OSC Prometheus deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://nvidia.github.io/dcgm-exporter/helm-charts | dcgm-exporter | 4.6.0 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.14.1 |
| https://prometheus-community.github.io/helm-charts/ | kube-state-metrics | 5.6.2 |
| oci://ghcr.io/prometheus-community/charts | kube-prometheus-stack | 85.4.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.oscServiceAccount | string | `"prometheus"` |  |
| global.nodeSelectorRole | string | `"infrastructure"` |  |
| global.imagePullSecret.name | string | `"osc-registry"` |  |
| global.imagePullSecret.registry | string | `"docker-registry.osc.edu"` |  |
| global.imagePullSecret.username | string | `"robot$osc-read"` |  |
| global.imagePullSecret.password | string | `nil` |  |
| global.networkPolicy.create | bool | `false` |  |
| global.webservicesDeploy.create | bool | `false` |  |
| global.auth.enable | bool | `true` |  |
| global.auth.upstream | string | `"http://prometheus-prometheus.{{ .Release.Namespace }}.svc.cluster.local:9090"` |  |
| global.ingress.host | string | `""` | Ingress host value |
| global.ingress.hostAlias | string | `""` | Ingress host alias |
| global.storageClass | string | `"nfs-infra"` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| kube-prometheus-stack.fullnameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.crds.enabled | bool | `false` |  |
| kube-prometheus-stack.crds.upgradeJob.enabled | bool | `false` |  |
| kube-prometheus-stack.defaultRules.create | bool | `false` |  |
| kube-prometheus-stack.alertmanager.enabled | bool | `false` |  |
| kube-prometheus-stack.grafana.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[0].sourceLabels[0] | string | `"__meta_kubernetes_namespace"` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[0].sourceLabels[1] | string | `"__meta_kubernetes_service_name"` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[0].sourceLabels[2] | string | `"__meta_kubernetes_endpoint_port_name"` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[0].action | string | `"keep"` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[0].regex | string | `"default;kubernetes;https"` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[1].action | string | `"labelmap"` |  |
| kube-prometheus-stack.kubeApiServer.serviceMonitor.relabelings[1].regex | string | `"__meta_kubernetes_service_label_(.+)"` |  |
| kube-prometheus-stack.kubelet.enabled | bool | `false` |  |
| kube-prometheus-stack.coreDns.service.enabled | bool | `false` |  |
| kube-prometheus-stack.coreDns.serviceMonitor.selector.matchLabels.k8s-app | string | `"kube-dns"` |  |
| kube-prometheus-stack.coreDns.serviceMonitor.port | string | `"metrics"` |  |
| kube-prometheus-stack.kubeEtcd.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeProxy.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeStateMetrics.enabled | bool | `false` |  |
| kube-prometheus-stack.nodeExporter.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheusOperator.fullnameOverride | string | `"prometheus-operator"` |  |
| kube-prometheus-stack.prometheusOperator.admissionWebhooks.deployment.enabled | bool | `true` |  |
| kube-prometheus-stack.prometheusOperator.admissionWebhooks.deployment.nodeSelector."node-role.kubernetes.io/infrastructure" | string | `""` |  |
| kube-prometheus-stack.prometheusOperator.admissionWebhooks.patch.nodeSelector."node-role.kubernetes.io/infrastructure" | string | `""` |  |
| kube-prometheus-stack.prometheusOperator.admissionWebhooks.certManager.enabled | bool | `true` |  |
| kube-prometheus-stack.prometheusOperator.resources.limits.cpu | int | `1` |  |
| kube-prometheus-stack.prometheusOperator.resources.limits.memory | string | `"1Gi"` |  |
| kube-prometheus-stack.prometheusOperator.resources.requests.cpu | string | `"500m"` |  |
| kube-prometheus-stack.prometheusOperator.resources.requests.memory | string | `"256Mi"` |  |
| kube-prometheus-stack.prometheusOperator.nodeSelector."node-role.kubernetes.io/infrastructure" | string | `""` |  |
| kube-prometheus-stack.prometheusOperator.prometheusConfigReloader.resources.limits.cpu | string | `"500m"` |  |
| kube-prometheus-stack.prometheusOperator.prometheusConfigReloader.resources.limits.memory | string | `"512Mi"` |  |
| kube-prometheus-stack.prometheusOperator.prometheusConfigReloader.resources.requests.cpu | string | `"100m"` |  |
| kube-prometheus-stack.prometheusOperator.prometheusConfigReloader.resources.requests.memory | string | `"128Mi"` |  |
| kube-prometheus-stack.prometheusOperator.kubeletService.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheusOperator.kubeletEndpointsEnabled | bool | `false` |  |
| kube-prometheus-stack.prometheusOperator.kubeletEndpointSliceEnabled | bool | `false` |  |
| kube-prometheus-stack.prometheus.service.port | int | `9090` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.image.tag | string | `"v3.11.3"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.persistentVolumeClaimRetentionPolicy.whenDeleted | string | `"Retain"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.persistentVolumeClaimRetentionPolicy.whenScaled | string | `"Retain"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeInterval | string | `"1m"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeTimeout | string | `"10s"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeClasses[0].name | string | `"kubernetes"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeClasses[0].default | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeClasses[0].tlsConfig.caFile | string | `"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeClasses[0].authorization.type | string | `"Bearer"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeClasses[0].authorization.credentialsFile | string | `"/var/run/secrets/kubernetes.io/serviceaccount/token"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.evaluationInterval | string | `"1m"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.retention | string | `"30d"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName | string | `"{{ .Values.global.storageClass }}"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.accessModes[0] | string | `"ReadWriteMany"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage | string | `"100Gi"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.limits.cpu | int | `4` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.limits.memory | string | `"16Gi"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.requests.cpu | int | `2` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.requests.memory | string | `"8Gi"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.nodeSelector."node-role.kubernetes.io/infrastructure" | string | `""` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.probeSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeConfigSelectorNilUsesHelmValues | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorNamespaceSelector.matchExpressions[0].key | string | `"osc.edu/role"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorNamespaceSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorNamespaceSelector.matchExpressions[0].values[0] | string | `"paas"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorNamespaceSelector.matchExpressions[0].key | string | `"osc.edu/role"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorNamespaceSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorNamespaceSelector.matchExpressions[0].values[0] | string | `"paas"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.securityContext.runAsGroup | int | `94` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.securityContext.runAsUser | int | `94` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.securityContext.fsGroup | int | `94` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.externalLabels.cluster | string | `"kubernetes"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.externalLabels.environment | string | `"{{ include \"osc.common.environment\" . }}"` |  |
| watch.image.repository | string | `"docker-registry.osc.edu/kubernetes/weaveworks/watch"` |  |
| watch.image.tag | string | `"master-0c44bf6"` |  |
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
| kedaNamespace | string | `"keda"` |  |
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
| kube-state-metrics.nodeSelector."node-role.kubernetes.io/infrastructure" | string | `""` |  |
| dcgm-exporter.nameOverride | string | `"dcgm-exporter"` |  |
| dcgm-exporter.fullnameOverride | string | `"dcgm-exporter"` |  |
| dcgm-exporter.image.repository | string | `"docker-registry.osc.edu/osc/dcgm-exporter"` |  |
| dcgm-exporter.image.tag | string | `"4.4.1-4.6.0-ubuntu22.04"` |  |
| dcgm-exporter.imagePullSecrets[0].name | string | `"osc-registry"` |  |
| dcgm-exporter.arguments[0] | string | `"--no-hostname"` |  |
| dcgm-exporter.extraEnv[0].name | string | `"__DCGM_DBG_LVL"` |  |
| dcgm-exporter.extraEnv[0].value | string | `"NONE"` |  |
| dcgm-exporter.podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| dcgm-exporter.podAnnotations."prometheus.io/port" | string | `"9400"` |  |
| dcgm-exporter.service.enable | bool | `false` |  |
| dcgm-exporter.service.port | int | `9400` |  |
| dcgm-exporter.serviceMonitor.enabled | bool | `false` |  |
| dcgm-exporter.resources.limits.cpu | string | `"2"` |  |
| dcgm-exporter.resources.limits.memory | string | `"1Gi"` |  |
| dcgm-exporter.resources.requests.cpu | string | `"1"` |  |
| dcgm-exporter.resources.requests.memory | string | `"512Mi"` |  |
| dcgm-exporter.nodeSelector."feature.node.kubernetes.io/pci-10de.present" | string | `"true"` |  |
| hook.image.repository | string | `"docker-registry.osc.edu/kubernetes/portainer/kubectl-shell"` |  |
| hook.image.tag | string | `"2.39.0"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
