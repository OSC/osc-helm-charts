# osc-mlflow

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart for mlflow deployment at OSC

## OSC MLFlow Chart

This chart handles the OSC's deployment of MLFlow.

Components:

* Postgresql
* Minio
* MLFlow

## Usage

The following is the minimal values to deploy this chart:

```yaml
---
global:
  imagePullSecret:
    password: <webservices-read password>
  ingress:
    host: <Ingress host>
    hostAlias: <Ingress host alias>
database:
  postgresql:
    auth:
      postgresPassword: <postgres root password>
      username: <username>
      password: <postgres database password>
  redis:
    auth:
      password: <redis password>

minio:
  auth:
    rootUser: <minio root username>
    rootPassword: <minio root password>

mlflow:
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://community-charts.github.io/helm-charts | mlflow | 1.11.7 |
| https://osc.github.io/osc-helm-charts | database | 0.21.0 |
| https://osc.github.io/osc-helm-charts | osc-common | 0.17.0 |
| oci://registry-1.docker.io/bitnamicharts | minio | 17.0.21 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imageRegistry | string | `"docker-registry.osc.edu"` |  |
| global.imagePullSecret.name | string | `"osc-registry"` |  |
| global.imagePullSecret.password | string | **required** | OSC registry password |
| global.oscServiceAccount | string | `"oscchat"` |  |
| global.storageClass | string | `"webservices-nfs-client"` |  |
| global.ingress.host | string | `""` |  |
| global.ingress.hostAlias | string | `""` |  |
| global.alert.receiver | string | `"sciapps"` |  |
| global.security.allowInsecureImages | bool | `true` |  |
| global.nodeSelectorRole | string | `"webservices"` |  |
| global.debugGroups[0] | string | `"sappstf"` |  |
| global.maintenanceGroups[0] | string | `"sappstf"` |  |
| database.postgresql.auth.postgresPassword | string | `"changeme-postgres"` |  |
| database.postgresql.auth.database | string | `"mlflow"` |  |
| database.postgresql.auth.username | string | `"mlflow"` |  |
| database.postgresql.auth.password | string | `"changeme-mlflow"` |  |
| database.postgresql.resources.limits.cpu | string | `"2000m"` |  |
| database.postgresql.resources.limits.memory | string | `"4Gi"` |  |
| database.postgresql.resources.requests.cpu | string | `"1000m"` |  |
| database.postgresql.resources.requests.memory | string | `"2Gi"` |  |
| database.postgresql.resources.requests.cpu | string | `"500m"` |  |
| database.postgresql.resources.requests.memory | string | `"1Gi"` |  |
| minio.enable | bool | `true` |  |
| minio.auth.rootUser | string | `"mlflowadmin"` |  |
| minio.auth.rootPassword | string | `"changeme-minio"` |  |
| minio.defaultBuckets | string | `"mlflow-artifacts"` |  |
| minio.commonLabels.receiver | string | `"{{ index .Values.global.alert.receiver }}"` |  |
| minio.image.repository | string | `"kubernetes/bitnami/minio"` |  |
| minio.image.tag | string | `"2025.7.23-debian-12-r5"` |  |
| minio.image.pullSecrets[0] | string | `"osc-registry"` |  |
| minio.persistence.enabled | bool | `true` |  |
| minio.persistence.storageClass | string | `"paas-nfs-client"` |  |
| minio.persistence.size | string | `"100Gi"` |  |
| minio.persistence.annotations."osc.edu/fileset" | string | `"PZS0645"` |  |
| minio.persistence.annotations."helm.sh/resource-policy" | string | `"keep"` |  |
| minio.service.type | string | `"ClusterIP"` |  |
| minio.service.rpcPort | int | `9000` |  |
| minio.service.consolePort | int | `9001` |  |
| minio.resources.limits.cpu | string | `"2000m"` |  |
| minio.resources.limits.memory | string | `"4Gi"` |  |
| minio.resources.requests.cpu | string | `"500m"` |  |
| minio.resources.requests.memory | string | `"1Gi"` |  |
| minio.metrics.enabled | bool | `true` |  |
| minio.metrics.serviceMonitor.enabled | bool | `true` |  |
| minio.metrics.serviceMonitor.interval | string | `"60s"` |  |
| minio.metrics.serviceMonitor.relabelings[0].sourceLabels[0] | string | `"__meta_kubernetes_service_label_receiver"` |  |
| minio.metrics.serviceMonitor.relabelings[0].targetLabel | string | `"receiver"` |  |
| minio.console.image.repository | string | `"kubernetes/bitnami/minio-object-browser"` |  |
| minio.console.image.tag | string | `"2.0.2-debian-12-r3"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"true"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` |  |
| ingress.paths[0].path | string | `"/"` |  |
| ingress.paths[0].pathType | string | `"ImplementationSpecific"` |  |
| mlflow.image.repository | string | `"docker-registry.osc.edu/kubernetes/mlflow"` |  |
| mlflow.image.tag | string | `"v3.17.1-full"` |  |
| mlflow.resources.requests.cpu | string | `"1000m"` |  |
| mlflow.resources.requests.memory | string | `"4Gi"` |  |
| mlflow.resources.limits.cpu | string | `"4000m"` |  |
| mlflow.resources.limits.memory | string | `"16Gi"` |  |
| mlflow.livenessProbe.httpGet.path | string | `"/health"` |  |
| mlflow.livenessProbe.httpGet.port | int | `5000` |  |
| mlflow.livenessProbe.initialDelaySeconds | int | `30` |  |
| mlflow.livenessProbe.periodSeconds | int | `10` |  |
| mlflow.livenessProbe.timeoutSeconds | int | `5` |  |
| mlflow.livenessProbe.failureThreshold | int | `3` |  |
| mlflow.readinessProbe.httpGet.path | string | `"/health"` |  |
| mlflow.readinessProbe.httpGet.port | int | `5000` |  |
| mlflow.readinessProbe.initialDelaySeconds | int | `10` |  |
| mlflow.readinessProbe.periodSeconds | int | `5` |  |
| mlflow.readinessProbe.timeoutSeconds | int | `3` |  |
| mlflow.readinessProbe.failureThreshold | int | `3` |  |
| mlflow.initImages.dbchecker.repository | string | `"docker-registry.osc.edu/kubernetes/busybox"` |  |
| mlflow.initImages.dbchecker.tag | string | `"1.38.0"` |  |
| mlflow.initImages.dbchecker.pullPolicy | string | `"IfNotPresent"` |  |
| mlflow.initImages.mlflowDbMigration.repository | string | `"docker-registry.osc.edu/kubernetes/mlflow"` |  |
| mlflow.initImages.mlflowDbMigration.tag | string | `"v3.17.1-full"` |  |
| mlflow.initImages.mlflowDbMigration.pullPolicy | string | `"IfNotPresent"` |  |
| mlflow.initImages.iniFileInitializer.repository | string | `"docker-registry.osc.edu/kubernetes/busybox"` |  |
| mlflow.initImages.iniFileInitializer.tag | string | `"1.38.0"` |  |
| mlflow.initImages.iniFileInitializer.pullPolicy | string | `"IfNotPresent"` |  |
| mlflow.backendStore.databaseMigration | bool | `true` |  |
| mlflow.backendStore.databaseConnectionCheck | bool | `true` |  |
| mlflow.backendStore.defaultSqlitePath | string | `":memory:"` |  |
| mlflow.backendStore.postgres.enabled | bool | `true` |  |
| mlflow.backendStore.postgres.host | string | `"osc-mlflow-postgresql"` |  |
| mlflow.backendStore.postgres.port | int | `5432` |  |
| mlflow.backendStore.postgres.database | string | `"mlflow"` |  |
| mlflow.backendStore.postgres.driver | string | `"psycopg2"` |  |
| mlflow.backendStore.existingDatabaseSecret.name | string | `"osc-mlflow-app-secrets"` |  |
| mlflow.backendStore.existingDatabaseSecret.usernameKey | string | `"pg_username"` |  |
| mlflow.backendStore.existingDatabaseSecret.passwordKey | string | `"pg_password"` |  |
| mlflow.artifactRoot.proxiedArtifactStorage | bool | `true` |  |
| mlflow.artifactRoot.defaultArtifactRoot | string | `"./mlruns"` |  |
| mlflow.artifactRoot.defaultArtifactsDestination | string | `"s3://mlflow-artifacts/"` |  |
| mlflow.extraEnvVars.AWS_DEFAULT_REGION | string | `"us-east-1"` |  |
| mlflow.extraEnvVars.MLFLOW_S3_ENDPOINT_URL | string | `"http://osc-mlflow-minio:9000"` |  |
| mlflow.extraEnvVars.MLFLOW_DEFAULT_ARTIFACT_ROOT | string | `"s3://mlflow-artifacts/"` |  |
| mlflow.extraSecretNamesForEnvFrom[0] | string | `"osc-mlflow-app-secrets"` |  |
| mlflow.auth.enabled | bool | `true` |  |
| mlflow.auth.adminUsername | string | `"admin"` |  |
| mlflow.auth.adminPassword | string | `"changeme-admin"` |  |
| mlflow.auth.postgres.enabled | bool | `true` |  |
| mlflow.auth.postgres.host | string | `"osc-mlflow-postgresql"` |  |
| mlflow.auth.postgres.port | int | `5432` |  |
| mlflow.auth.postgres.database | string | `"mlflow"` |  |
| mlflow.auth.postgres.existingSecret.name | string | `"osc-mlflow-app-secrets"` |  |
| mlflow.auth.postgres.existingSecret.usernameKey | string | `"pg_username"` |  |
| mlflow.auth.postgres.existingSecret.passwordKey | string | `"pg_password"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
