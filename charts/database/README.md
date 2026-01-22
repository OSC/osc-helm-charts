# database

![Version: 0.15.0](https://img.shields.io/badge/Version-0.15.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC database service Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mariadb | 21.0.8 |
| https://charts.bitnami.com/bitnami | postgresql | 16.7.27 |
| https://charts.bitnami.com/bitnami | redis | 23.2.12 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.7.0 |

## Usage

### Allow access using Ingress

Enable Ingress access:

```yaml
global:
  database:
    allowIngress: true
```

### MariaDB

Enable MariaDB:

```yaml
mariadb:
  enable: true
  auth:
    rootPassword: secret
    database: name
    username: name
    password: secret
```

### PostgreSQL

Enable PostgreSQL:

```yaml
postgresql:
  enable: true
  auth:
    postgresPassword: secret
    database: name
    username: name
    password: secret
```

### Redis

Enable Redis

```yaml
redis:
  enable: true
  auth:
    password: secret
```

## Values

| Key | Description | Default |
|-----|-------------|---------|
| global.imagePullSecret.name | image pull secret name | `"osc-registry"` |
| global.imagePullSecret.registry | OSC registry address | `"docker-registry.osc.edu"` |
| global.imagePullSecret.username | OSC registry username | `"robot$webservices-read"` |
| global.imagePullSecret.password | The image pull secret password for database images | **required** |
| global.nodeSelectorRole | The nodeSelector role | `"webservices"` |
| global.storageClass | The persistent storage class | `"webservices-nfs-client"` |
| global.imageRegistry | Global value to pass down to database charts to set registry to pull images from | `"docker-registry.osc.edu"` |
| global.imagePullSecrets | The OSC image pull secret name to use to pull images | `["osc-registry"]` |
| global.database.allowIngress | Allow Ingress access | `false` |
| global.ingressName | The name of IGNIX Ingress | `"ingress-nginx"` |
| global.security.allowInsecureImages |  | `true` |
| imagePullSecret.enable | Manage the image pull secret from osc-common. Disable if this chart is used as a subchart. | `true` |
| mariadb.enable | Enable MariaDB subchart by setting to `true` | `false` |
| mariadb.image.repository | The OSC registry path to mariadb replicated image. This value should not need to be changed. | `"webservices/mariadb"` |
| mariadb.image.tag | The version of MariaDB image. **This version of must built by this repo** | `"11.8.3-debian-12-r0"` |
| mariadb.primary.resources | Set limits for primary MariaDB pod | `{"limits":{"cpu":4,"memory":"4Gi"},"requests":{"cpu":1,"memory":"256Mi"}}` |
| mariadb.volumePermissions.image.repository | The OSC registry path to replicated image. This value should not need to be changed. | `"kubernetes/bitnami/os-shell"` |
| mariadb.volumePermissions.image.tag | The version of replicated image. **This version of must replicated to OSC registry** | `"12-debian-12-r51"` |
| mariadb.metrics.image.repository | The OSC registry path to replicated image. This value should not need to be changed. | `"kubernetes/bitnami/mysqld-exporter"` |
| mariadb.metrics.image.tag | The version of replicated image. **This version of must replicated to OSC registry** | `"0.17.2-debian-12-r16"` |
| postgresql.enable | Enable PostgreSQL subchart by setting to `true` | `false` |
| postgresql.image.repository | The OSC registry path to postgresql replicated image. This value should not need to be changed. | `"webservices/postgresql"` |
| postgresql.image.tag | The version of MariaDB image. **This version of must built by this repo** | `"17.6.0-debian-12-r4"` |
| postgresql.auth.postgresPassword | The postgres user admin password | **required** |
| postgresql.auth.database | The database name | **required** |
| postgresql.auth.username | The database username | **required** |
| postgresql.auth.password | The database password | **required** |
| postgresql.primary.resources | Set limits for primary PostgreSQL pod | `{"limits":{"cpu":"4","memory":"4Gi"},"requests":{"cpu":"1","memory":"256Mi"}}` |
| postgresql.volumePermissions.image.repository | The OSC registry path to replicated image. This value should not need to be changed. | `"kubernetes/bitnami/os-shell"` |
| postgresql.volumePermissions.image.tag | The version of replicated image. **This version of must replicated to OSC registry** | `"12-debian-12-r51"` |
| postgresql.metrics.enabled |  | `true` |
| postgresql.metrics.image.repository | The OSC registry path to replicated image. This value should not need to be changed. | `"kubernetes/bitnami/postgres-exporter"` |
| postgresql.metrics.image.tag | The version of replicated image. **This version of must replicated to OSC registry** | `"0.17.1-debian-12-r16"` |
| redis.enable | Enable Redis subchart by setting to `true` | `false` |
| redis.image.repository | The OSC registry path to redis replicated image. This value should not need to be changed. | `"kubernetes/bitnami/redis"` |
| redis.image.tag | The version of Redis image. **This version of must built by this repo** | `"8.2.1-debian-12-r0"` |
| redis.auth.password | The Redis password | **required** |
| redis.architecture |  | `"standalone"` |
| redis.master.resources | Set limits for master Redis pod | `{"limits":{"cpu":"4","memory":"4Gi"},"requests":{"cpu":"1","memory":"256Mi"}}` |
| redis.metrics.enabled |  | `true` |
| redis.metrics.image.repository | The OSC registry path to replicated image. This value should not need to be changed. | `"kubernetes/bitnami/redis-exporter"` |
| redis.metrics.image.tag | The version of replicated image. **This version of must replicated to OSC registry** | `"1.76.0-debian-12-r0"` |
