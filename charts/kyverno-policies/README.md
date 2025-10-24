# kyverno-policies

![Version: 0.29.5](https://img.shields.io/badge/Version-0.29.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.13.2](https://img.shields.io/badge/AppVersion-v1.13.2-informational?style=flat-square)

OSC Kyverno policies deployment

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kyverno.github.io/kyverno/ | kyverno-policies | 3.3.2 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.7.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| users.allowHostPaths[0] | string | `"/var/lib/sss/pipes"` |  |
| users.allowHostPaths[1] | string | `"/etc/sssd"` |  |
| users.allowHostPaths[2] | string | `"/etc/nsswitch.conf"` |  |
| users.allowHostPaths[3] | string | `"/etc/pam.d"` |  |
| users.allowHostPaths[4] | string | `"/etc/slurm"` |  |
| users.allowHostPaths[5] | string | `"/var/run/munge/munge.socket.2"` |  |
| users.allowHostPaths[6] | string | `"/users/?*"` |  |
| users.allowHostPaths[7] | string | `"/fs/?*"` |  |
| users.allowHostPaths[8] | string | `"/apps/?*"` |  |
| users.allowHostPaths[9] | string | `"/nfsroot/?*"` |  |
| users.authorizedRegistries[0] | string | `"docker-registry.osc.edu"` |  |
| users.authorizedRegistries[1] | string | `"docker-registry-test.osc.edu"` |  |
| webservices.allowHostPaths[0] | string | `"/var/lib/sss/pipes"` |  |
| webservices.allowHostPaths[1] | string | `"/etc/sssd"` |  |
| webservices.allowHostPaths[2] | string | `"/etc/nsswitch.conf"` |  |
| webservices.allowHostPaths[3] | string | `"/etc/slurm"` |  |
| webservices.allowHostPaths[4] | string | `"/var/run/munge/munge.socket.2"` |  |
| webservices.allowHostPaths[5] | string | `"/users/?*"` |  |
| webservices.allowHostPaths[6] | string | `"/fs/?*"` |  |
| webservices.authorizedRegistries[0] | string | `"docker-registry.osc.edu"` |  |
| webservices.authorizedRegistries[1] | string | `"docker-registry-test.osc.edu"` |  |
| webservices.authorizedRegistries[2] | string | `"quay.io/oauth2-proxy/oauth2-proxy"` |  |
| webservices.validNodeSelector[0] | string | `"infrastructure"` |  |
| webservices.validNodeSelector[1] | string | `"webservices"` |  |
| paas.allowHostPaths[0] | string | `"/var/lib/sss/pipes"` |  |
| paas.allowHostPaths[1] | string | `"/etc/sssd"` |  |
| paas.allowHostPaths[2] | string | `"/etc/nsswitch.conf"` |  |
| paas.allowHostPaths[3] | string | `"/etc/slurm"` |  |
| paas.allowHostPaths[4] | string | `"/var/run/munge/munge.socket.2"` |  |
| paas.allowHostPaths[5] | string | `"/users/?*"` |  |
| paas.allowHostPaths[6] | string | `"/fs/?*"` |  |
| paas.authorizedRegistries[0] | string | `"docker-registry.osc.edu"` |  |
| paas.authorizedRegistries[1] | string | `"docker-registry-test.osc.edu"` |  |
| paas.authorizedRegistries[2] | string | `"quay.io/oauth2-proxy/oauth2-proxy"` |  |
| paas.validNodeSelector[0] | string | `"paas"` |  |
| paas.certManagerClusterIssuer | string | `"letsencrypt"` |  |
| paas.ingressClassName | string | `"nginx"` |  |
| validationFailureAction | object | `{}` |  |
| kyverno-policies.podSecurityStandard | string | `"restricted"` |  |
| kyverno-policies.includeOtherPolicies[0] | string | `"require-non-root-groups"` |  |
| kyverno-policies.podSecuritySeverity | string | `"medium"` |  |
| kyverno-policies.validationFailureAction | string | `"Enforce"` |  |
| kyverno-policies.policyExclude.disallow-host-path.any[0].resources.namespaces[0] | string | `"user-?*"` |  |
| kyverno-policies.policyExclude.disallow-host-path.any[1].resources.kinds[0] | string | `"Pod"` |  |
| kyverno-policies.policyExclude.disallow-host-path.any[1].resources.namespaceSelector.matchExpressions[0].key | string | `"osc.edu/role"` |  |
| kyverno-policies.policyExclude.disallow-host-path.any[1].resources.namespaceSelector.matchExpressions[0].operator | string | `"In"` |  |
| kyverno-policies.policyExclude.disallow-host-path.any[1].resources.namespaceSelector.matchExpressions[0].values[0] | string | `"webservice"` |  |
| kyverno-policies.policyExclude.disallow-host-path.any[1].resources.namespaceSelector.matchExpressions[0].values[1] | string | `"paas"` |  |
| kyverno-policies.policyExclude.restrict-volume-types.any[0].resources.namespaces[0] | string | `"user-?*"` |  |
| kyverno-policies.policyExclude.restrict-volume-types.any[1].resources.kinds[0] | string | `"Pod"` |  |
| kyverno-policies.policyExclude.restrict-volume-types.any[1].resources.namespaceSelector.matchExpressions[0].key | string | `"osc.edu/role"` |  |
| kyverno-policies.policyExclude.restrict-volume-types.any[1].resources.namespaceSelector.matchExpressions[0].operator | string | `"In"` |  |
| kyverno-policies.policyExclude.restrict-volume-types.any[1].resources.namespaceSelector.matchExpressions[0].values[0] | string | `"webservice"` |  |
| kyverno-policies.policyExclude.restrict-volume-types.any[1].resources.namespaceSelector.matchExpressions[0].values[1] | string | `"paas"` |  |
| kyverno-policies.policyPreconditions.disallow-capabilities.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.disallow-capabilities.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.disallow-capabilities.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.disallow-capabilities-strict.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.disallow-capabilities-strict.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.disallow-capabilities-strict.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.disallow-privilege-escalation.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.disallow-privilege-escalation.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.disallow-privilege-escalation.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.disallow-host-path.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.disallow-host-path.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.disallow-host-path.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.require-run-as-non-root-user.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.require-run-as-non-root-user.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.require-run-as-non-root-user.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.require-run-as-nonroot.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.require-run-as-nonroot.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.require-run-as-nonroot.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.check-runasgroup.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.check-runasgroup.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.check-runasgroup.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.restrict-seccomp-strict.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.restrict-seccomp-strict.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.restrict-seccomp-strict.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.policyPreconditions.restrict-volume-types.all[0].key | string | `"{{ request.object.metadata.labels.\"app.kubernetes.io/name\" || '' }}"` |  |
| kyverno-policies.policyPreconditions.restrict-volume-types.all[0].operator | string | `"NotEquals"` |  |
| kyverno-policies.policyPreconditions.restrict-volume-types.all[0].value | string | `"dcgm-exporter"` |  |
| kyverno-policies.nameOverride | string | `nil` |  |
| kyverno-policies.customLabels | object | `{}` | Additional labels |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
