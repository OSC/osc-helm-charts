# osc-common

![Version: 0.14.0](https://img.shields.io/badge/Version-0.14.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC common Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://docker-registry.osc.edu/kubernetes | oauth2-proxy | 10.5.0-osc-r2 |

## Usage

### Auth with OAuth2 Proxy

To use OAuth2 Proxy the following is the minimal configuration:

```yaml
global:
  oscServiceAccount: username
  auth:
    enable: true
    upstream: http://{{ .Release.Name }}.{{ .Release.Namespace }}.svc.cluster.local:80
  ingress:
    host: test.example.com
```

For a service that does built-in OAuth you can disable OAuth2 Proxy but keep the necessary KeycloakClient configuration

```yaml
global:
  oscServiceAccount: username
  auth:
    enable: false
    keycloakClient:
      forceCreate: true
  ingress:
    host: test.example.com
```

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
| global.oscServiceAccount | The service account used by OSC deployments. **required** Also pulled from global.env.<env>.serviceAccount | `""` |
| global.environment | The deployment's OSC environment. Value is set by Puppet when deployed to OSC. | `"production"` |
| global.nodeSelectorRole | The OSC node role to use with nodeSelector | `"webservices"` |
| global.imagePullSecret.create | Create the image pull secret | `true` |
| global.imagePullSecret.name | imagePullSecret name | `"osc-registry"` |
| global.imagePullSecret.registry | imagePullSecret registry | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username | imagePullSecret username | `"robot$webservices-read"` |
| global.imagePullSecret.password | imagePullSecret password. This value will be set by OSC's Puppet. This value must be set to IMAGE-PULL-PASSWORD for CI tests. | `nil` |
| global.networkPolicy.create | Create the network policy | `true` |
| global.networkPolicy.podSelector | Labels for NetworkPolicy podSelector. Defaults to `"osc.common.selectorLabels"` | `nil` |
| global.networkPolicy.ingressAllowedPods | Labels of pods allowed to Ingress from the same namespace | `[]` |
| global.networkPolicy.ingressNamespace | Name of the Ingress namespace | `"ingress-nginx"` |
| global.networkPolicy.prometheusNamespace | Name of the Prometheus namespace | `"prometheus"` |
| global.networkPolicy.ports | Ports that should be used for the network policy | `[]` |
| global.debugGroups | Groups that debug pods | `[]` |
| global.maintenanceGroups | Groups that can perform maintenance operations | `[]` |
| global.portforwardGroups | Groups that are allowed to perform port forwarding | `[]` |
| global.webservicesDeploy.create | Create webservices deployment rolebinding | `true` |
| global.webservicesDeploy.clusterRole | OSC managed webservices-deploy ClusterRole name | `"webservices-deploy"` |
| global.webservicesDeploy.serviceAccount | OSC managed webservices-deploy ServiceAccount name | `"webservices-deploy"` |
| global.auth.enable | Enable auth management | `false` |
| global.auth.upstream | The upstream service for the OAuth2 proxy. **required** when auth is enabled | `""` |
| global.auth.skipAuthRoutes | Routes to skip auth | `[]` |
| global.auth.allowGroups | Restrict access to these groups | `[]` |
| global.auth.commonAllowGroups | Common groups to allow | `["sysstf"]` |
| global.auth.redirectUriPath | Path used for redirect URI | `"/*"` |
| global.auth.defaultClientScopes | Default client scopes for the Keycloak client | `["web-origins","roles","profile","groups","osc-oidc-clients","basic","email"]` |
| global.auth.extraDefaultClientScropes | Extra default client scopes for the Keycloak client | `[]` |
| global.auth.keycloakClient.forceCreate | Force creating KeycloakClient when Oauth2 Proxy management is disabled | `false` |
| global.auth.keycloakClient.secret.name | The secret name for the Keycloak Client secret @default <Release name>-secret | `""` |
| global.auth.keycloakClient.configmap.name | The configmap name for the Keycloak Client config @default <Release name>-config | `""` |
| global.auth.keycloakClient.config | Additional Keycloak Client configs | `{}` |
| global.ingress.host | Ingress host value | `""` |
| global.ingress.hostAlias | Ingress host alias | `""` |
| global.ingress.additionalHosts | Ingress additional hosts | `[]` |
| global.alert.receiver | The alert receiver name | `""` |
| oauth2-proxy.image.registry | The OSC registry | The OSC registry hostname |
| oauth2-proxy.image.repository | Path to oauth2-proxy on the OSC registry | `"kubernetes/oauth2-proxy"` |
| oauth2-proxy.image.tag | oauth2-proxy image tag.  **must be replicated to the OSC registry** | `"v7.15.0"` |
| oauth2-proxy.resources.limits.cpu | CPU limit for OAuth2 Proxy pods | `"200m"` |
| oauth2-proxy.resources.limits.memory | Memory limit for OAuth2 Proxy pods | `"128Mi"` |
| oauth2-proxy.resources.requests.cpu | CPU request for OAuth2 Proxy pods | `"100m"` |
| oauth2-proxy.resources.requests.memory | Memory request for OAuth2 Proxy pods | `"64Mi"` |
| oauth2-proxy.ingress.enabled | Enable OAuth2 Proxy Ingress | `true` |
| oauth2-proxy.ingress.extraPaths | Additional Ingress paths | `[]` |
