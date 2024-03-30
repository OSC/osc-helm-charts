# paas

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

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
  groups: ['testgroup']
- name: foo
  serviceAccount: foo-account
  groups: ['bar']
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| namespaces | Define PAAS namespaces | `{}` |
