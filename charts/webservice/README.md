# webservice

![Version: 0.40.0](https://img.shields.io/badge/Version-0.40.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC webservice bootstrap Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | database | 0.12.0 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.13.0 |

## Usage

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.imagePullSecret.registry | OSC container registry | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username | OSC container registry robot account | `"robot$webservices-read"` |
| global.imagePullSecret.password | Password for the robot account. | **required** |
| global.nodeSelectorRole | The nodeSelector role | `"webservices"` |
| global.storageClass | The persistent storage class | `"webservices-nfs-client"` |
| global.auth.enable | Enable auth management | `true` |
| global.auth.upstream | The upstream service for the OAuth2 proxy. **required** when auth is enabled | `"http://{{ include \"webservice.name\" $ }}.{{ $.Release.Namespace }}.svc.cluster.local:{{ .Values.global.service.port }}"` |
| global.auth.skipAuthRoutes | Routes to skip auth | `[]` |
| global.auth.allowGroups | Restrict access to these groups | `[]` |
| global.auth.commonAllowGroups | Common groups to allow | `["sysstf"]` |
| global.ingress.host | Ingress host | `""` |
| global.ingress.hostAlias | Ingress host alias | `""` |
| global.debugGroups | Groups that debug pods | `[]` |
| global.maintenanceGroups | Groups that can perform maintenance operations | `[]` |
| global.alert.receiver | The alert receiver name. Also pulled from global.env.$environment.alert.receiver | `""` |
| global.service.port | Service port | `3000` |
| appType |  | `"rails"` |
| command | Command to start webservice | `[]` |
| args | Args to start webservice | `[]` |
| workingDir | webservice working directory | `nil` |
| env | List environment variables, eg: `{"name": "<name>", "value": "<value>"}` | `[]` |
| defaultCommand.rails | Default command when `appType` is `rails` | `["bundle","exec","passenger","start"]` |
| defaultCommand.rshiny | Default command when `appType` is `rshiny` | `["/bin/passenger","start"]` |
| defaultCommand.none | Default command when `appType` is `none` | `[]` |
| defaultArgs.rails | Default args when `appType` is `rails` | `["--min-instances=1","--sticky-sessions","--start-timeout=180","--environment=production","--disable-security-update-check","--disable-anonymous-telemetry","--log-file=/dev/stdout","--pid-file=/tmp/passenger-{{ .name }}.pid"]` |
| defaultArgs.rshiny | Default args when `appType` is `rshiny` | `["--min-instances=1","--sticky-sessions","--start-timeout=180","--environment=production","--disable-security-update-check","--disable-anonymous-telemetry","--log-file=/dev/stdout","--pid-file=/tmp/passenger-{{ .name }}.pid","--app-start-command","{{ .startCommand | default \"R --no-save --slave -f /app/entrypoint.R --args $$PORT\" }}"]` |
| defaultArgs.none | Default args when `appType` is `none` | `[]` |
| containers[0].name |  | `"{{ include \"webservice.name\" . }}"` |
| containers[0].port |  | `nil` |
| containers[0].portName |  | `"http"` |
| containers[0].startCommand |  | `nil` |
| containers[0].probePath |  | `nil` |
| containers[0].probeType |  | `nil` |
| containers[0].ingressPath |  | `"/"` |
| image.repository | Image repository. | **required** |
| image.tag | Image tag. Also pulled from `global.env.<env>.image.tag`. | **required** |
| image.pullPolicy | imagePullPolicy.  **Forced to `Always` when image tag contains `:latest`**. | `"IfNotPresent"` |
| mounts.emptyDir |  | `{}` |
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
| service.annotations |  | `{}` |
| service.typeAnnotations.rshiny | Default Service annotations when `appType` is `rshiny` | `{"prometheus.io/probe_module":"http","prometheus.io/probe_scheme":"http"}` |
| probes.type | Type of probes to use, eg `httpGet` or `tcpSocket` | httpGet |
| probes.path |  | `"/"` |
| probes.typeDefaults.rshiny | Type of probes to use when `appType` is `rshiny`. | `"tcpSocket"` |
| startupProbe.httpGet | Config for httpGet startupProbe | `{"path":"{{ .probePath | default .Values.probes.path }}","port":"{{ .portName | default .name }}"}` |
| startupProbe.tcpSocket | Config for tcpSocket startupProbe | `{"port":"{{ .portName | default .name }}"}` |
| startupProbe.failureThreshold | startupProbe failureThreshold | `12` |
| startupProbe.periodSeconds | startupProbe periodSeconds | `10` |
| startupProbe.timeoutSeconds | startupProbe timeoutSeconds | `5` |
| livenessProbe.httpGet | Config for httpGet livenessProbe | `{"path":"{{ .probePath | default .Values.probes.path }}","port":"{{ .portName | default .name }}"}` |
| livenessProbe.tcpSocket | Config for tcpSocket livenessProbe | `{"port":"{{ .portName | default .name }}"}` |
| livenessProbe.failureThreshold | livenessProbe failureThreshold | `6` |
| livenessProbe.periodSeconds | livenessProbe periodSeconds | `10` |
| livenessProbe.timeoutSeconds | livenessProbe timeoutSeconds | `5` |
| readinessProbe.httpGet | Config for httpGet readinessProbe | `{"path":"{{ .probePath | default .Values.probes.path }}","port":"{{ .portName | default .name }}"}` |
| readinessProbe.tcpSocket | Config for tcpSocket readinessProbe | `{"port":"{{ .portName | default .name }}"}` |
| readinessProbe.failureThreshold | readinessProbe failureThreshold | `6` |
| readinessProbe.periodSeconds | readinessProbe periodSeconds | `10` |
| readinessProbe.timeoutSeconds | readinessProbe timeoutSeconds | `5` |
| initContainers | webservice init containers | `{}` |
| init.podResources | init container pod resource limits | `{"limits":{"cpu":1,"memory":"1Gi"},"requests":{"cpu":"200m","memory":"256Mi"}}` |
| ingress.className |  | `"nginx"` |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" |  | `"8k"` |
| ingress.rShinyAnnotations | ingress annotations used when `appType` is `rshiny` | `{"nginx.ingress.kubernetes.io/proxy-read-timeout":"86400","nginx.ingress.kubernetes.io/proxy-send-timeout":"3600","nginx.ingress.kubernetes.io/server-snippets":"location / {\n  proxy_http_version 1.1;\n  proxy_set_header Upgrade $http_upgrade;\n  proxy_set_header Connection $connection_upgrade;\n  proxy_buffering off;\n }\n"}` |
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
