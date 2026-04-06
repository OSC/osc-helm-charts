# cryosparc

![Version: 0.6.0](https://img.shields.io/badge/Version-0.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.7.1p251124-r3](https://img.shields.io/badge/AppVersion-4.7.1p251124--r3-informational?style=flat-square)

OSC CryoSPARC bootstrap Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| zyou |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.13.0 |

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
  ingress:
    host: cryosciapps.k8.osc.edu
    hostAlias: cryosciapps.osc.edu
  basePort: 31010
  project: PAS0710

license: xxx-xxx-xxx
admin:
  email: qwer1234@osc.edu
  password: qwer1234
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.oscServiceAccount | The service account used by OSC deployments. | The chart's release name |
| global.environment | The deployment's OSC environment | `"production"` |
| global.nodeSelectorRole | The OSC node role to use with nodeSelector | `"webservices"` |
| global.imagePullSecret.create | Create the image pull secret | `true` |
| global.imagePullSecret.name | imagePullSecret name | `"osc-registry"` |
| global.imagePullSecret.registry | imagePullSecret registry | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username | imagePullSecret username | `"robot$webservices-read"` |
| global.imagePullSecret.password | imagePullSecret password. This value will be set by OSC's Puppet. This value must be set to IMAGE-PULL-PASSWORD for CI tests. | `nil` |
| global.debugGroups | Groups that debug pods | `[]` |
| global.maintenanceGroups | Groups that can perform maintenance operations | `[]` |
| global.auth.commonAllowGroups | Base groups allowed to login | `["sappstf","sysstf","{{ .Values.global.project }}"]` |
| global.auth.allowGroups | Additional groups allowed to login | `[]` |
| global.ingress.host | Ingress host. | **required** |
| global.ingress.hostAlias | Ingress host alias. | **required** |
| global.alert.receiver |  | `"sciapps"` |
| global.basePort | The base service port. Must be unique for each CryoSPARC instance | **required** |
| global.project | The service project | **required** |
| license | The CryoSPARC license ID | `""` |
| homeDir |  | `"{{ .Values.global.project }}"` |
| slurmConf | Slurm configuration of the cluster used for service | `"/etc/slurm/slurm-ascend.conf"` |
| worker_bin_path.ascend | The CryoSPARC worker binary path for Ascend cluster | `"/apps/cryosparc-worker/{{ regexReplaceAll \"-r.*$\" (include \"cryosparc.imageTag\" .) \"\" }}/bin/cryosparcw"` |
| worker_bin_path.cardinal | The CryoSPARC worker binary path for Cardinal cluster | `"/apps/cryosparc-worker/{{ regexReplaceAll \"-r.*$\" (include \"cryosparc.imageTag\" .) \"\" }}/bin/cryosparcw"` |
| worker_bin_path.pitzer | The CryoSPARC worker binary path for Pitzer cluster | `"/apps/cryosparc-worker/{{ regexReplaceAll \"-r.*$\" (include \"cryosparc.imageTag\" .) \"\" }}/bin/cryosparcw"` |
| image.repository | The CryoSPARC image URL | `"docker-registry.osc.edu/webservices/cryosparc"` |
| image.tag | The CryoSPARC image tag | `""` |
| image.pullPolicy |  | `"IfNotPresent"` |
| mounts.home |  | `"/users/{{ tpl .Values.homeDir . }}/{{ tpl (include \"osc.common.serviceAccountValue\" .) . }}"` |
| mounts.project |  | `"/fs/ess/{{ required \"Project must be provided\" .Values.global.project }}"` |
| admin.email |  | `""` |
| admin.password |  | `""` |
| nodeSelector |  | `{}` |
