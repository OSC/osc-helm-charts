# osc-common

![Version: 0.8.0](https://img.shields.io/badge/Version-0.8.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC common Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Helpers

| Key | Description| Source |
|-----|------------|--------|
| osc.common.environment | The environment | `global.environment` (def: `production`) |
| osc.common.serviceAccountKey | The service account label key | osc.edu/service-account |
| osc.common.serviceAccountValue | The global or environment service account | `global.env.<env>.serviceAccount` or `global.oscServiceAccount` |
| osc.common.serviceAccount | The `key: value` of service account that is to be embedded in deployment labels | `{"osc.common.serviceAccountKey": "osc.common.serviceAccountValue"}` |
| osc.common.nodeSelectorRoleKey | The nodeSelector role key | `global.nodeSelectorRole` |
| osc.common.nodeSelectorRole | The full `key: value` nodeSelector role that should be used to set nodeSelector | "osc.common.nodeSelectorRoleKey" |
| osc.common.roleKey | The label key for role associated with pods | default: `osc.edu/role` |
| osc.common.role | The full `key: value` role that should be used with pod labels | `{"osc.common.roleKey": "global.nodeSelectorRole"}` |
| osc.common.imagePullSecret.name | The imagePullSecret name | `global.imagePullSecret.name` (def: `osc-registry`) |
| osc.common.imagePullSecret | The imagePullSecret base64 encoded to be passed into a Secret | `global.imagePullSecret` |

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.oscServiceAccount | The service account used by OSC deployments. Also pulled from global.env.<env>.serviceAccount | `""` |
| global.environment | The deployment's OSC environment | `"production"` |
| global.nodeSelectorRole | The OSC node role to use with nodeSelector | `""` |
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
| global.portforwardGroups | Groups that are allowed to perform port forwarding | `[]` |
