# kyverno-policies

![Version: 0.34.1](https://img.shields.io/badge/Version-0.34.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.13.2](https://img.shields.io/badge/AppVersion-v1.13.2-informational?style=flat-square)

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

## Policies

### Table of Contents
* [Pod policies](#pod-policies)
  * [Validating policies](#pod-policies-validating-policies)
  * [Mutate policies](#pod-policies-mutate-policies)
* [PersistentVolumeClaim policies](#persistentvolumeclaim-policies)
  * [Mutate policies](#persistentvolumeclaim-policies-mutate-policies)
* [StatefulSet policies](#statefulset-policies)
  * [Mutate policies](#statefulset-policies-mutate-policies)
* [Ingress policies](#ingress-policies)
  * [Mutate policies](#ingress-policies-mutate-policies)
  * [Validating policies](#ingress-policies-validating-policies)
* [PAAS policies](#paas-policies)
  * [Mutate policies](#paas-policies-mutate-policies)
* [User policies](#user-policies)
  * [Validating policies](#user-policies-validating-policies)

### Pod policies

#### Validating policies

* [authorized-registries](templates/authorized-registries.yaml)
  * Validates that images come from authorized registries based on namespace
  * Applies to: Pod in user-?* namespaces, webservice namespaces, and PAAS namespaces

* [block-images-with-volumes](templates/block-images-with-volumes.yaml)
  * Blocks pods that use images containing built-in volumes
  * Applies to: Pod

* [disallow-container-sock-mounts](templates/disallow-container-sock-mounts.yaml)
  * Disallows mounting container daemon sockets (docker, containerd, crio)
  * Applies to: Pod

* [disallow-nfs](templates/disallow-nfs.yaml)
  * Disallows use of NFS volumes in pods
  * Applies to: Pod

#### Mutate policies

* [add-account](templates/add-account.yaml)
  * Adds account label to pods in PAAS namespace
  * Applies to: PAAS namespace

* [add-gpu-nodeselector](templates/add-gpu-nodeselector.yaml)
  * Adds GPU nodeselector to pods that request GPU resources
  * Applies to: Pod

* [add-image-pull-secret](templates/add-image-pull-secret.yaml)
  * Adds image pull secret to pods in PAAS namespace
  * Applies to: PAAS namespace

* [add-nodeselector](templates/add-nodeselector.yaml)
  * Adds nodeselector to pods based on namespace role (ondemand or paas)
  * Applies to: Pod in user-?* namespaces or PAAS namespaces

* [add-service-account](templates/add-service-account.yaml)
  * Adds service account security context to pods in webservice and PAAS namespaces
  * Applies to: Pod in webservice and PAAS namespaces

### PersistentVolumeClaim policies

#### Mutate policies

* [add-pvc-service-account](templates/add-pvc-service-account.yaml)
  * Adds service account annotations to persistent volume claims in webservice and PAAS namespaces
  * Applies to: PersistentVolumeClaim in webservice and PAAS namespaces

### StatefulSet policies

#### Mutate policies

* [add-statefulset-service-account](templates/add-statefulset-service-account.yaml)
  * Adds service account annotations to statefulset volume claim templates in webservice and PAAS namespaces
  * Applies to: StatefulSet in webservice and PAAS namespaces

### Ingress policies

#### Mutate policies

* [add-ingress-class-name](templates/add-ingress-class-name.yaml)
  * Adds ingress class name to ingresses in PAAS namespace
  * Applies to: Ingress in PAAS namespace

#### Validating policies

* [ingress-allowed-dns](templates/ingress-allowed-dns.yaml)
  * Validates that ingress DNS hosts are in the allowed list
  * Applies to: Ingress in PAAS namespace

* [ingress-annotations](templates/ingress-annotations.yaml)
  * Validates that external-dns annotations are not used
  * Applies to: Ingress in PAAS namespace

* [ingress-require-tls](templates/ingress-require-tls.yaml)
  * Validates that ingresses have TLS configured
  * Applies to: Ingress

### PAAS policies

#### Mutate policies

* [add-annotations](templates/add-annotations.yaml)
  * Adds annotations to PAAS pods, services, and ingresses
  * Applies to: Pod, Service in PAAS namespace and Ingress in PAAS namespace

* [add-role](templates/add-role.yaml)
  * Adds osc.edu/role label to pods, services, and ingresses in PAAS namespace
  * Applies to: Pod, Service, Ingress in PAAS namespace

### User policies

#### Validating policies

* [disallow-pvc](templates/disallow-pvc.yaml)
  * Disallows use of persistent volume claims in pods and statefulsets and disallows PersistentVolumeClaims
  * Applies to: Pod, PersistentVolumeClaim, and StatefulSet in user-?* namespaces

## Values

| Key | Description | Default |
|-----|-------------|---------|
| users.allowHostPaths | Allowed host paths for user namespaces | `["/var/lib/sss/pipes","/etc/sssd","/etc/nsswitch.conf","/etc/pam.d","/etc/slurm","/var/run/munge/munge.socket.2","/users/?*","/fs/?*","/apps/?*","/nfsroot/?*"]` |
| users.authorizedRegistries | Authorized registries for user namespaces | `["docker-registry.osc.edu","docker-registry-test.osc.edu"]` |
| webservices.allowHostPaths | Allowed host paths for webservices | `["/var/lib/sss/pipes","/etc/sssd","/etc/nsswitch.conf","/etc/slurm","/var/run/munge/munge.socket.2","/users/?*","/fs/?*"]` |
| webservices.authorizedRegistries | Authorized registries for webservices | `["docker-registry.osc.edu","docker-registry-test.osc.edu","quay.io/oauth2-proxy/oauth2-proxy"]` |
| webservices.validNodeSelector | Allowed node selectors for webservices | `["infrastructure","webservices"]` |
| webservices.validStorageClass | Allowed storage classes for webservices | `["local-ess","local-path","webservices-nfs-client"]` |
| paas.allowHostPaths | Allowed host paths for PAAS namespaces | `["/var/lib/sss/pipes","/etc/sssd","/etc/nsswitch.conf","/etc/slurm","/var/run/munge/munge.socket.2","/users/?*","/fs/?*"]` |
| paas.authorizedRegistries | Authorized registries for PAAS namespaces | `["docker-registry.osc.edu","docker-registry-test.osc.edu","quay.io/oauth2-proxy/oauth2-proxy"]` |
| paas.validNodeSelector | Allowed node selectors for PAAS namespaces | `["paas"]` |
| paas.certManagerClusterIssuer | The cert-manager cluster issuer for PAAS namespaces | `"letsencrypt"` |
| paas.ingressClassName | The Ingress class name for PAAS namespaces | `"nginx"` |
| paas.validStorageClass.paas | Allow storage classes for PAAS namespaces | `["local-ess"]` |
| paas.validStorageClass.paasStaff | Allowed storage classes for staff PAAS namespaces | `["local-ess","local-path","paas-nfs-client"]` |
| kyverno-policies.podSecurityStandard | Pod Security Standard profile (`baseline`, `restricted`, `privileged`, `custom`). For more info https://kyverno.io/policies/pod-security. | `"restricted"` |
| kyverno-policies.includeOtherPolicies | Additional policies to include from `other`. | `["require-non-root-groups"]` |
| kyverno-policies.podSecuritySeverity | Pod Security Standard (`low`, `medium`, `high`). | `"medium"` |
| kyverno-policies.validationFailureAction | Validation failure action (`Audit`, `Enforce`). For more info https://kyverno.io/docs/policy-types/cluster-policy/validate. | `"Enforce"` |
| kyverno-policies.nameOverride |  | `nil` |
| kyverno-policies.customLabels | Additional labels | `{}` |
