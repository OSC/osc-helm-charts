# cryosparc

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC CryoSPARC bootstrap Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| zyou |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.8.1 |

## Usage

Define necessary values:

```yaml
global:
  oscServiceAccount: cryosciapps
  imagePullSecret:
    password: IMAGE-PULL-PASSWORD
  nodeSelectorRole: test
  debugGroups:
    - foobar
  maintenanceGroups:
    - foo
    - bar

license: xxx-xxx-xxx
version: 4.7.1
revision: 1
project: PAS0710
admin:
  email: qwer1234@osc.edu
  username: qwer1234
  password: qwer1234
nodeSelector:
  kubernetes.io/os: linux
auth:
  clientSecret: client-secret
  cookieSecret: secret
ingress:
  host: cryosciapps.osc.edu
podSecurityContext:
  runAsUser: 12345
  runAsGroup: 3333
  fsGroup: 3333
service:
  basePort: 31010
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.oscServiceAccount | The service account used by OSC deployments. Also pulled from global.env.<env>.serviceAccount | `"{{ include \"cryosparc.name\" . }}"` |
| global.environment | The deployment's OSC environment | `"production"` |
| global.nodeSelectorRole | The OSC node role to use with nodeSelector | `"webservices"` |
| global.imagePullSecret.create | Create the image pull secret | `true` |
| global.imagePullSecret.name | imagePullSecret name | `"osc-registry"` |
| global.imagePullSecret.registry | imagePullSecret registry | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username | imagePullSecret username | `"robot$webservices-read"` |
| global.imagePullSecret.password | imagePullSecret password. This value will be set by OSC's Puppet. This value must be set to IMAGE-PULL-PASSWORD for CI tests. | `nil` |
| global.networkPolicy.create | Create the network policy | `true` |
| global.networkPolicy.ingressLabels | Labels to allow Ingress from the same namespace | `{}` |
| global.networkPolicy.ingressNamespace | Name of the Ingress namespace | `"ingress-nginx"` |
| global.networkPolicy.prometheusNamespace | Name of the Prometheus namespace | `"prometheus"` |
| global.debugGroups | Groups that debug pods | `[]` |
| global.maintenanceGroups | Groups that can perform maintenance operations | `[]` |
| global.auth.idpHost | Keycloak IDP host.  Default if auth.idpHost not defined | `nil` |
| global.auth.clientID | Keycloak client ID.  Default if auth.clientID not defined | `nil` |
| global.auth.clientSecret | Keycloak client secret.  Default if auth.clientSecret not defined | `nil` |
| global.auth.cookieSecret | Keycloak cookie secret.  Default if auth.cookieSecret not defined | `nil` |
| global.ingress.host | Ingress host.  Default if ingress.host not defined | `nil` |
| global.ingress.hostAlias | Ingress host alias.  Default if ingress.hostAlias not defined | `nil` |
| global.env.production.podResources.limits.cpu |  | `8` |
| global.env.production.podResources.limits.memory |  | `"32Gi"` |
| global.env.production.podResources.requests.cpu |  | `4` |
| global.env.production.podResources.requests.memory |  | `"16Gi"` |
| global.env.production.auth.replicas |  | `2` |
| global.env.test.podResources.limits.cpu |  | `1` |
| global.env.test.podResources.limits.memory |  | `"4Gi"` |
| global.env.test.podResources.requests.cpu |  | `1` |
| global.env.test.podResources.requests.memory |  | `"256Mi"` |
| global.env.test.auth.replicas |  | `2` |
| global.env.dev.podResources.limits.cpu |  | `1` |
| global.env.dev.podResources.limits.memory |  | `"4Gi"` |
| global.env.dev.podResources.requests.cpu |  | `1` |
| global.env.dev.podResources.requests.memory |  | `"256Mi"` |
| global.env.dev.auth.replicas |  | `1` |
| license | The CryoSPARC license ID | `""` |
| version | The CryoSPARC version | `""` |
| revision | The revision used by the CryoSPARC container image | `1` |
| project | The service project | `""` |
| homeDir |  | `"{{ .Values.project }}"` |
| slurmConf | Slurm configuration of the cluster used for service | `"/etc/slurm/slurm-ascend.conf"` |
| image.repository |  | `"docker-registry.osc.edu/webservices/cryosparc"` |
| image.tag |  | `"{{ required \"Version must be provided\" .Values.version }}-r{{ .Values.revision }}"` |
| image.pullPolicy |  | `"IfNotPresent"` |
| mounts.home |  | `"/users/{{ tpl .Values.homeDir . }}/{{ tpl (include \"osc.common.serviceAccountValue\" .) . }}"` |
| mounts.project |  | `"/fs/ess/{{ required \"Project must be provided\" .Values.project }}"` |
| admin.email |  | `""` |
| admin.password |  | `""` |
| nodeSelector |  | `{}` |
| alert.receiver |  | `"sciapps"` |
| service.port |  | `80` |
| service.basePort |  | `31000` |
| ingress.host | Ingress host. Also pulled from global.ingress.host | `""` |
| ingress.hostAlias | Ingress host alias.  Also pulled from global.ingress.hostAlias | `""` |
| ingress.className |  | `"nginx"` |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" |  | `"16k"` |
| ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" |  | `"true"` |
| auth.clientID | Keycloak client ID. Also pulled from global.auth.clientID | `"kubernetes-{{ include \"cryosparc.name\" . }}"` |
| auth.clientSecret | Keycloak client secret. Also pulled from global.auth.clientSecret | `nil` |
| auth.cookieSecret | Keycloak cookie secret. Also pulled from global.auth.cookieSecret | `nil` |
| auth.cookieName |  | `"_{{ tpl (include \"osc.common.serviceAccountValue\" .) . }}{{ include \"osc.common.environment\" . }}"` |
| auth.idpHost | Keycloak IDP host. Also pulled from global.auth.idpHost | `nil` |
| auth.oidcIssuerURL |  | `"https://$(IDP_HOST)/realms/osc"` |
| auth.allowGroupsBase | Base groups allowed to login | `["sappstf","sysstf","{{ .Values.project }}"]` |
| auth.allowGroups | Additional groups allowed to login | `[]` |
| auth.skipAuthRoute |  | `nil` |
| auth.image.repository |  | `"quay.io/oauth2-proxy/oauth2-proxy"` |
| auth.image.tag |  | `"v7.1.3"` |
| auth.image.pullPolicy |  | `"IfNotPresent"` |
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
| auth.ingress.className |  | `nil` |
| auth.ingress.annotations."prometheus.io/probe_path" |  | `"/ping"` |
| auth.podDistributionBudget.minAvailable |  | `1` |
