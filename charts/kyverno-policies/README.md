# kyverno-policies

![Version: 0.34.2](https://img.shields.io/badge/Version-0.34.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.13.2](https://img.shields.io/badge/AppVersion-v1.13.2-informational?style=flat-square)

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
* [Service policies](#service-policies)
  * [Validating policies](#service-policies-validating-policies)
* [Namespace policies](#namespace-policies)
  * [Validating policies](#namespace-policies-validating-policies)
* [PAAS policies](#paas-policies)
  * [Mutate policies](#paas-policies-mutate-policies)
* [User policies](#user-policies)
  * [Validating policies](#user-policies-validating-policies)
* [Infrastructure policies](#infrastructure-policies)
  * [Mutate policies](#infrastructure-policies-mutate-policies)

### Pod policies

#### Validating policies

* [authorized-registries](templates/authorized-registries.yaml)
  * Rules
    * Validates that images come from authorized registries for user namespaces
    * Validates that images come from authorized registries for webservice namespaces
    * Validates that images come from authorized registries for PAAS namespaces
  * Applies to: Pod in user-?* namespaces, webservice namespaces, and PAAS namespaces

* [block-images-with-volumes](templates/block-images-with-volumes.yaml)
  * Rules
    * Blocks pods that use images containing built-in volumes
  * Applies to: Pod

* [disallow-container-sock-mounts](templates/disallow-container-sock-mounts.yaml)
  * Rules
    * Validates that Docker Unix socket is not mounted
    * Validates that Containerd Unix socket is not mounted
    * Validates that CRI-O Unix socket is not mounted
  * Applies to: Pod

* [disallow-nfs](templates/disallow-nfs.yaml)
  * Rules
    * Validates that NFS volumes are not used in pods
  * Applies to: Pod

* [pod-account-validation](templates/pod-account-validation.yaml)
  * Rules
    * Validates pod account labels and authorization for user namespaces
    * Validates pod account authorization for PAAS namespaces
  * Applies to: Pod in user-?* namespaces and PAAS namespaces

* [pod-groups-validation](templates/pod-groups-validation.yaml)
  * Rules
    * Validates pod supplemental groups authorization for user namespaces
  * Applies to: Pod in user-?* namespaces

* [pod-host-port](templates/pod-host-port.yaml)
  * Rules
    * Blocks pods with host port configuration in user namespaces
    * Blocks pods with host port configuration in PAAS namespaces
  * Applies to: Pod in user-?* namespaces and PAAS namespaces

* [pod-lifetime](templates/pod-lifetime.yaml)
  * Rules
    * Validates pod lifetime annotation requirement for user namespaces
    * Validates pod lifetime does not exceed 24h limit for user namespaces
  * Applies to: Pod in user-?* namespaces

* [pod-nodeselector](templates/pod-nodeselector.yaml)
  * Rules
    * Validates pod node selector for user namespaces
    * Validates pod node selector for webservice namespaces
    * Validates pod node selector for PAAS namespaces
  * Applies to: Pod in user-?* namespaces, webservice namespaces, and PAAS namespaces

* [pod-resources](templates/pod-resources.yaml)
  * Rules
    * Validates pod resource requests and limits for user namespaces
    * Validates pod resource limits do not exceed maximum for user namespaces
    * Validates pod resource requests and limits for webservice namespaces
    * Validates pod resource limits do not exceed maximum for webservice namespaces
  * Applies to: Pod in user-?* namespaces and webservice namespaces

* [pod-service-account-validation](templates/pod-service-account-validation.yaml)
  * Rules
    * Validates webservice pods require a service account for access
    * Validates webservice pods have valid service account UID/GID
    * Validates webservice pods have valid service account groups
    * Validates PAAS pods have valid service account UID/GID
    * Validates PAAS pods have valid service account groups
  * Applies to: Pod in webservice and PAAS namespaces

* [pod-user-validation](templates/pod-user-validation.yaml)
  * Rules
    * Validates pod has valid user UID for user namespaces
    * Validates pod has valid user GID for user namespaces
    * Validates pod has valid group GID for user namespaces
  * Applies to: Pod in user-?* namespaces

#### Mutate policies

* [add-account](templates/add-account.yaml)
  * Rules
    * Adds account label to pods in PAAS namespace
  * Applies to: PAAS namespace

* [add-gpu-nodeselector](templates/add-gpu-nodeselector.yaml)
  * Rules
    * Adds GPU nodeselector to pods that request GPU resources
    * Removes GPU nodeselector from pods that no longer request GPU resources
  * Applies to: Pod

* [add-image-pull-secret](templates/add-image-pull-secret.yaml)
  * Rules
    * Adds image pull secret to pods in PAAS namespace
  * Applies to: PAAS namespace

* [add-nodeselector](templates/add-nodeselector.yaml)
  * Rules
    * Adds ondemand nodeselector to pods in user namespaces
    * Adds paas nodeselector to pods in PAAS namespaces
  * Applies to: Pod in user-?* namespaces or PAAS namespaces

* [add-service-account](templates/add-service-account.yaml)
  * Rules
    * Adds service account security context to webservice pods
    * Adds service account security context to PAAS pods
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

* [no-ingress](templates/no-ingress.yaml)
  * Blocks ingress in user namespaces
  * Applies to: Ingress in user-?* namespaces

### Service policies

#### Validating policies

* [no-localhost-service](templates/no-localhost-service.yaml)
  * Blocks ExternalName services pointing to localhost
  * Applies to: Service of type ExternalName

### Namespace policies

#### Validating policies

* [namespace-account](templates/namespace-account.yaml)
  * Validates that namespaces have an account label set when they have the paas role
  * Applies to: Namespace with paas role

* [namespace-role](templates/namespace-role.yaml)
  * Validates that namespaces have a role label set
  * Applies to: Namespace (excluding default, user-*, and kube-* namespaces)

* [namespace-service-account](templates/namespace-service-account.yaml)
  * Validates that namespaces have a service account label set when they have the paas role
  * Applies to: Namespace with paas role

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

### Infrastructure policies

#### Mutate policies

* [mutate-calico-registry](templates/mutate-calico-registry.yaml)
  * Mutates calico container images to use the internal registry and adds image pull secrets
  * Applies to: Pod in kube-system namespace with calico-* k8s-app label

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
