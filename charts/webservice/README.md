# webservice

![Version: 0.34.0](https://img.shields.io/badge/Version-0.34.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC webservice bootstrap Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | database | 0.12.0 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.7.0 |

## Usage

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.imagePullSecret.name | image pull secret name | `"osc-registry"` |
| global.imagePullSecret.registry | OSC registry address | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username | OSC registry username | `"robot$webservices-read"` |
| global.imagePullSecret.password | The image pull secret password for database images | **required** |
| global.nodeSelectorRole | The nodeSelector role | `"webservices"` |
| global.storageClass | The persistent storage class | `"webservices-nfs-client"` |
| global.ingressName | The name of IGNIX Ingress | `"ingress-nginx"` |
| appType | The webservice application type. Choices currently are `rails`, `rshiny` and `none`. This is used to set the default command and args | `"rails"` |
| command | Command to start webservice | `[]` |
| args | Args to start webservice | `[]` |
| workingDir | webservice working directory | `nil` |
| env | List environment variables, eg: `{"name": "<name>", "value": "<value>"}` | `[]` |
| defaultCommand.rails | Default command when `appType` is `rails` | `["bundle","exec","passenger","start"]` |
| defaultCommand.rshiny | Default command when `appType` is `rshiny` | `["/bin/passenger","start"]` |
| defaultCommand.none | Default command when `appType` is `none` | `[]` |
| defaultArgs.rails | Default args when `appType` is `rails` | `["--port={{ .Values.service.port }}","--min-instances=1","--sticky-sessions","--start-timeout=180","--environment=production","--disable-security-update-check","--disable-anonymous-telemetry","--log-file=/dev/stdout","--pid-file=/tmp/passenger.pid"]` |
| defaultArgs.rshiny | Default args when `appType` is `rshiny` | `["--port={{ .Values.service.port }}","--min-instances=1","--sticky-sessions","--start-timeout=180","--environment=production","--disable-security-update-check","--disable-anonymous-telemetry","--log-file=/dev/stdout","--pid-file=/tmp/passenger.pid","--app-start-command","R --no-save --slave -f /app/entrypoint.R --args $$PORT"]` |
| defaultArgs.none | Default args when `appType` is `none` | `[]` |
| image.repository | Image repository. | **required** |
| image.tag | Image tag. Also pulled from `global.env.<env>.image.tag`. | **required** |
| mounts.home | webservice home mount that is mounted at same location inside pod | `""` |
| mounts.roDir | Read-only directory volumes, `name=path`. | `{}` |
| mounts.rwDir | Read-write directory volumes, `name=path`. | `{}` |
| mounts.socket | Socket volumes, `name=path`. | `{}` |
| mounts.roFile | Read-only file volumes, `name=path`. | `{}` |
| nodeSelector | Additional nodeSelector that is added to existing role selection. | `{}` |
| podResources | The pod resource limits | `{"limits":{"cpu":4,"memory":"4Gi"},"requests":{"cpu":1,"memory":"256Mi"}}` |
| replicas | Number of replicas. Also pulled from `global.env.<env>.replicas` | 1 |
| secrets | Secrets for this webservice, eg `{"name": "value"}` | `{}` |
| envSecrets | Environment secrets for this webservice, eg `{"NAME": "value"}` | `{}` |
| debugGroups | List of OSC groups that are authorized to perform debug actions like query pod logs. | `[]` |
| alert.receiver | Prometheus alert receiver. Also pulled from `global.env.<env>.alert.receiver` | `nil` |
| service.port | The port the webservice listens on | `3000` |
| service.annotations | Service annotations | `{}` |
| service.typeAnnotations.rshiny | Default Service annotations when `appType` is `rshiny` | `{"prometheus.io/probe_module":"http","prometheus.io/probe_scheme":"http"}` |
| probes.type | Type of probes to use, eg `httpGet` or `tcpSocket` | `"httpGet"` |
| probes.typeDefaults.rshiny | This overrides probes.type | `"tcpSocket"` |
| startupProbe.httpGet | Config for httpGet startupProbe | `{"path":"/","port":"http"}` |
| startupProbe.tcpSocket | Config for tcpSocket startupProbe | `{"port":"http"}` |
| startupProbe.failureThreshold | startupProbe failureThreshold | `12` |
| startupProbe.periodSeconds | startupProbe periodSeconds | `10` |
| startupProbe.timeoutSeconds | startupProbe timeoutSeconds | `5` |
| livenessProbe.httpGet | Config for httpGet livenessProbe | `{"path":"/","port":"http"}` |
| livenessProbe.tcpSocket | Config for tcpSocket livenessProbe | `{"port":"http"}` |
| livenessProbe.failureThreshold | livenessProbe failureThreshold | `6` |
| livenessProbe.periodSeconds | livenessProbe periodSeconds | `10` |
| livenessProbe.timeoutSeconds | livenessProbe timeoutSeconds | `5` |
| readinessProbe.httpGet | Config for httpGet readinessProbe | `{"path":"/","port":"http"}` |
| readinessProbe.tcpSocket | Config for tcpSocket readinessProbe | `{"port":"http"}` |
| readinessProbe.failureThreshold | readinessProbe failureThreshold | `6` |
| readinessProbe.periodSeconds | readinessProbe periodSeconds | `10` |
| readinessProbe.timeoutSeconds | readinessProbe timeoutSeconds | `5` |
| initContainers | webservice init containers | `{}` |
| init.podResources | init container pod resource limits | `{"limits":{"cpu":1,"memory":"1Gi"},"requests":{"cpu":"200m","memory":"256Mi"}}` |
| ingress.host | ingress host, also pulled from `global.env.<env>.ingress.host` | `""` |
| ingress.hostAlias | ingress host alias, also pulled from `global.env.<env>.ingress.hostAlias` | `""` |
| ingress.annotations | ingress annotations | `{"kubernetes.io/ingress.class":"nginx","nginx.ingress.kubernetes.io/proxy-buffer-size":"8k"}` |
| ingress.rShinyAnnotations | ingress annotations used when `appType` is `rshiny` | `{"nginx.ingress.kubernetes.io/proxy-read-timeout":"86400","nginx.ingress.kubernetes.io/proxy-send-timeout":"3600","nginx.ingress.kubernetes.io/server-snippets":"location / {\n  proxy_http_version 1.1;\n  proxy_set_header Upgrade $http_upgrade;\n  proxy_set_header Connection $connection_upgrade;\n  proxy_buffering off;\n }\n"}` |
| auth.enable | Enable oauth proxy authentication with Keycloak | `true` |
| auth.clientSecret | Keycloak client secret | **required** |
| auth.cookieSecret | Oauth cookie secret | **required** |
| auth.idpHost | The Keycloak IDP host, also pulled from `global.env.<env>.auth.idpHost` | `nil` |
| auth.accessGroup | Restrict webservice access to this group. Also pulled from `global.env.<env>.auth.accessGroup` | `""` |
| auth.allowGroups | Additional groups to allow access | `[]` |
| auth.replicas | Number of auth replicas. Also pulled from `global.env.<env>.auth.replicas` | 1 |
| data.enable | Enable use of persistent data volume | `false` |
| data.storageSize | Persistent data volume size | `"10Gi"` |
| data.path | Persistent data volume mount path | `"/data"` |
| database.enable | Enable database subchart | `false` |
| database.mariadb.enable | Enable MariaDB database | `false` |
| database.mariadb.auth.rootPassword | The root user admin password | **required** |
| database.mariadb.auth.database | The database name | **required** |
| database.mariadb.auth.username | The database username | **required** |
| database.mariadb.auth.password | The database password | **required** |
| database.postgresql.enable | Enable PostgreSQL database | `false` |
| database.postgresql.auth.postgresPassword | The postgres user admin password | **required** |
| database.postgresql.auth.database | The database name | **required** |
| database.postgresql.auth.username | The database username | **required** |
| database.postgresql.auth.password | The database password | **required** |
