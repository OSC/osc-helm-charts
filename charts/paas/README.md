# paas

![Version: 0.8.0](https://img.shields.io/badge/Version-0.8.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC PAAS bootstrap Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.7.0 |

## Usage

Define PAAS namespaces and the groups that can manage the resources:

```
namespaces:
- name: test
  serviceAccount: test-account
  account: test
  groups: ['testgroup']
  allowedDNS:
    - test.osc.edu
    - test.k8.osc.edu
- name: foo
  serviceAccount: foo-account
  account: foo
  groups: ['bar']
  allowedDNS:
    - foo.osc.edu
    - foo.k8.osc.edu
  managePVC: true
  cpuLimit: '8'
  cpuDefault: '1'
  memoryLimit: '16Gi'
  memoryDefault: '2Gi'
  gpuLimit: '1'
  imagePullSecret:
    username: testuser
    password: password
```

## Namespace properties

| Key | Description | Default |
|-----|-------------|---------|
| name | Namespace name | **required** |
| serviceAccount | The user that will run pods | **required** |
| account | The charge account for this namespace | **required** |
| groups | The groups that can manage the namespace's resources | `[]` |
| users | The users that can manage the namespace's resources | `[]` |
| allowedDNS | Allowed DNS entries for namespace's Ingress resources | `[]` |
| managePVC | Allows managing PVC in the namespace | `false` |
| collectLogs | Collect pod logs | `false` |
| allowNodeport | Allow NodePort services | `false` |
| cpuLimit | The max CPU this namespace can consume | `4` |
| cpuDefault | The default CPU request for this namespace | `1` |
| memoryLimit | The max memory this namespace can consume | `8Gi` |
| memoryDefault | The default memory request for this namespace | `2Gi` |
| gpuLimit | The max GPUs this namespace can consume | `0` |
| imagePullSecret.username | The username used to access the registry | **required** if `imagePullSecret` defined |
| imagePullSecret.password | The password used to access the registry | **required** if `imagePullSecret` defined |

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.imagePullSecret.name | Image pull secret name for PAAS namespaces | `"osc-registry"` |
| global.imagePullSecret.registry | Registry for image pull secret added to all PAAS namespaces | `"docker-registry.osc.edu"` |
| namespaces | Define PAAS namespaces | `{}` |
| resourcePolicy | resource-policy setting | `"keep"` |
| default.cpuLimit | The default CPU limit for PAAS namespaces | `"4"` |
| default.cpu | The default CPU request for PAAS namespace pods | `"1"` |
| default.memoryLimit | The default memory limit for PAAS namespaces | `"8Gi"` |
| default.memory | The default memory request for PAAS namespace pods | `"2Gi"` |
| default.gpuLimit | The default GPU limit for PAAS namespaces | `"0"` |
| default.managePVC | Allow managing PVCs | `false` |
