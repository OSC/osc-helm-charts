# osc-common

![Version: 0.6.0](https://img.shields.io/badge/Version-0.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC common Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Helpers

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| osc.common.environment | string | production | The environment|
| osc.common.serviceAccountKey | string | osc.edu/service-account | The service account label key|
| osc.common.serviceAccountValue| string | **required** | The global or environment service account|
| osc.common.serviceAccount| key/value | **required** | The `key: value` of service account that is to be embedded in deployment labels|
| osc.common.nodeSelectorRoleKey| string | | The nodeSelector role key|
| osc.common.nodeSelectorRole| string | | The full `key: value` nodeSelector role that should be used to set nodeSelector|
| osc.common.imagePullSecret.name| string| osc-registry | The imagePullSecret name|
| osc.common.imagePullSecret | string | | The imagePullSecret base64 encoded to be passed into a Secret|

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.oscServiceAccount | string | `""` | The service account used by OSC deployments. Also pulled from global.env.<env>.serviceAccount |
| global.nodeSelectorRole | string | `""` | The OSC node role to use with nodeSelector |
| global.imagePullSecret.name | string | `"osc-registry"` | imagePullSecret name |
| global.imagePullSecret.registry | string | `"docker-registry.osc.edu"` | imagePullSecret registry |
| global.imagePullSecret.username | string | `"robot$webservices-read"` | imagePullSecret username |
| global.imagePullSecret.password | string | `nil` | imagePullSecret password. This value will be set by OSC's Puppet. This value must be set to IMAGE-PULL-PASSWORD for CI tests. |
