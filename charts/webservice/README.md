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

See [charts-private](../../charts-private) for examples.

## Values

### Image Config

| Key | Description | Default |
|-----|-------------|---------|
| global.imagePullSecret.username | OSC container registry robot account | `"robot$webservices-read"` |
| global.imagePullSecret.password | Password for the robot account. | **required** |
| image.repository | Image repository. | **required** |
| image.tag | Image tag. Also pulled from `global.env.<env>.image.tag`. | **required** |
| image.pullPolicy | imagePullPolicy.  **Forced to `Always` when image tag contains `:latest`**. | `"IfNotPresent"` |

### Authentication

| Key | Description | Default |
|-----|-------------|---------|
| global.auth.enable | Enable auth management | `true` |
| global.auth.upstream | The upstream service for the OAuth2 proxy. **required** when auth is enabled | `"http://{{ include \"webservice.name\" $ }}.{{ $.Release.Namespace }}.svc.cluster.local:{{ .Values.global.service.port }}"` |
| global.auth.skipAuthRoutes | Routes to skip auth | `[]` |
| global.auth.allowGroups | Restrict access to these groups | `[]` |
| global.auth.commonAllowGroups | Common groups to allow | `["sysstf"]` |

### Ingress

| Key | Description | Default |
|-----|-------------|---------|
| global.ingress.host | Ingress host | **required** |
| global.ingress.hostAlias | Ingress host alias | **required** |

### Extra RBAC

| Key | Description | Default |
|-----|-------------|---------|
| global.debugGroups | Groups that debug pods | `[]` |
| global.maintenanceGroups | Groups that can perform maintenance operations | `[]` |

### App Config

| Key | Description | Default |
|-----|-------------|---------|
| global.service.port | Service port | `3000` |
| appType | The application type | `"rails"` |
| command | Command to start webservice | Pulled from `defaultCommand` |
| args | Args to start webservice | Pulled from `defaultArgs` |
| workingDir | webservice working directory | `nil` |
| env | List environment variables, eg: `{"name": "<name>", "value": "<value>"}` | `[]` |
| defaultCommand.rails | Default command when `appType` is `rails` | Command for Rails |
| defaultCommand.rshiny | Default command when `appType` is `rshiny` | Command for RShiny |
| defaultCommand.none | Default command when `appType` is `none` | `[]` |
| defaultArgs.rails | Default args when `appType` is `rails` | Rails args |
| defaultArgs.rshiny | Default args when `appType` is `rshiny` | RShiny args |
| defaultArgs.none | Default args when `appType` is `none` | `[]` |
| containers | Containers used to run the web service | A single container |

### Mounts

| Key | Description | Default |
|-----|-------------|---------|
| mounts.emptyDir | emptyDir mounts | `{}` |
| mounts.home | webservice home mount that is mounted at same location inside pod | `""` |
| mounts.roDir | Read-only directory volumes, `name: path`. | `{}` |
| mounts.rwDir | Read-write directory volumes, `name: path`. | `{}` |
| mounts.socket | Socket volumes, `name: path`. | `{}` |
| mounts.roFile | Read-only file volumes, `name: path`. | `{}` |

### Database

| Key | Description | Default |
|-----|-------------|---------|
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

### Other Values

| Key | Description | Default |
|-----|-------------|---------|
| global.nodeSelectorRole | The nodeSelector role | `"webservices"` |
| global.storageClass | The persistent storage class | `"webservices-nfs-client"` |
| global.alert.receiver | The alert receiver name. Also pulled from global.env.$environment.alert.receiver @section - Monitoring | `""` |
| nodeSelector | Additional nodeSelector that is added to existing role selection. | `{}` |
| podResources.limits.cpu | The pod CPU limits | `4` |
| podResources.limits.memory | The pod memory limits | `"4Gi"` |
| podResources.requests.cpu | The pod CPU request | `1` |
| podResources.requests.memory | The pod memory request | `"256Mi"` |
| replicas | Number of replicas. Also pulled from `global.env.<env>.replicas` | 1 |
| secrets | Secrets for this webservice, eg `{"name": "value"}` | `{}` |
| envSecrets | Environment secrets for this webservice, eg `{"NAME": "value"}` | `{}` |
| service.annotations | Additional service annotations | `{}` |
| service.typeAnnotations.rshiny | Default Service annotations when `appType` is `rshiny` | Specific to rshiny |
| probes.type | Type of probes to use, eg `httpGet` or `tcpSocket` | `httpGet` |
| probes.path | Default probe path for probes | `"/"` |
| probes.typeDefaults.rshiny | Type of probes to use when `appType` is `rshiny`. | `"tcpSocket"` |
| startupProbe.httpGet.path | Config for httpGet startupProbe path | container `probePath` or `probes.path` |
| startupProbe.httpGet.port | Config for httpGet startupProbe port | container `portName` or container `name` |
| startupProbe.tcpSocket | Config for tcpSocket startupProbe | container `portName` or container `name` |
| startupProbe.failureThreshold | startupProbe failureThreshold | `12` |
| startupProbe.periodSeconds | startupProbe periodSeconds | `10` |
| startupProbe.timeoutSeconds | startupProbe timeoutSeconds | `5` |
| livenessProbe.httpGet.path | Config for httpGet livenessProbe path | container `probePath` or `probes.path` |
| livenessProbe.httpGet.port | Config for httpGet livenessProbe port | container `portName` or container `name` |
| livenessProbe.tcpSocket | Config for tcpSocket livenessProbe | container `portName` or container `name` |
| livenessProbe.failureThreshold | livenessProbe failureThreshold | `6` |
| livenessProbe.periodSeconds | livenessProbe periodSeconds | `10` |
| livenessProbe.timeoutSeconds | livenessProbe timeoutSeconds | `5` |
| readinessProbe.httpGet.path | Config for httpGet readinessProbe path | container `probePath` or `probes.path` |
| readinessProbe.httpGet.port | Config for httpGet readinessProbe port | container `portName` or container `name` |
| readinessProbe.tcpSocket | Config for tcpSocket readinessProbe | container `portName` or container `name` |
| readinessProbe.failureThreshold | readinessProbe failureThreshold | `6` |
| readinessProbe.periodSeconds | readinessProbe periodSeconds | `10` |
| readinessProbe.timeoutSeconds | readinessProbe timeoutSeconds | `5` |
| initContainers | webservice init containers | `{}` |
| init.podResources.limits.cpu | init container pod CPU limits | `1` |
| init.podResources.limits.memory | init container pod memory limits | `"1Gi"` |
| init.podResources.requests.cpu | init container pod CPU request | `"200m"` |
| init.podResources.requests.memory | init container pod memory request | `"256Mi"` |
| data.enable | Enable use of persistent data volume | `false` |
| data.storageSize | Persistent data volume size | `"10Gi"` |
| data.path | Persistent data volume mount path | `"/data"` |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
