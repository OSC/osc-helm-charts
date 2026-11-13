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
| https://khsa1.github.io/helm-charts | mlflow | 1.11.8 |
| https://osc.github.io/osc-helm-charts | database | 0.21.1 |
| https://osc.github.io/osc-helm-charts | osc-common | 0.17.4 |
| https://osc.github.io/osc-helm-charts | osc-minio | 0.1.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imageRegistry | string | `"docker-registry.osc.edu"` |  |
| global.imagePullSecret.name | string | `"osc-registry"` |  |
| global.imagePullSecret.password | string | **required** | OSC registry password |
| global.oscServiceAccount | string | `"mlflow"` |  |
| global.storageClass | string | `"local-ess"` |  |
| global.ingress.host | string | `""` |  |
| global.ingress.hostAlias | string | `""` |  |
| global.ingress.minio.api | string | `""` |  |
| global.ingress.minio.console | string | `""` |  |
| global.alert.receiver | string | `"sciapps"` |  |
| global.security.allowInsecureImages | bool | `true` |  |
| global.nodeSelectorRole | string | `"webservices"` |  |
| global.fileset | string | `"PZS0645"` |  |
| global.postgresql.auth.username | string | `"mlflow"` |  |
| global.postgresql.auth.password | string | `"changeme-mlflow"` |  |
| global.postgresql.auth.postgresPassword | string | `"changeme-postgres"` |  |
| global.postgresql.auth.database | string | `"mlflow"` |  |
| global.minio.auth.rootUser | string | `"mlflowadmin"` |  |
| global.minio.auth.rootPassword | string | `"changeme-minio"` |  |
| global.mlflow.auth.adminUsername | string | `"admin"` |  |
| global.mlflow.auth.adminPassword | string | `"changeme-admin"` |  |
| global.debugGroups[0] | string | `"sappstf"` |  |
| global.maintenanceGroups[0] | string | `"sappstf"` |  |
| database.postgresql.auth.postgresPassword | string | `"{{ .Values.global.postgresql.auth.postgresPassword }}"` |  |
| database.postgresql.auth.database | string | `"{{ .Values.global.postgresql.database }}"` |  |
| database.postgresql.auth.username | string | `"{{ .Values.global.postgresql.auth.username }}"` |  |
| database.postgresql.auth.password | string | `"{{ .Values.global.postgresql.auth.password }}"` |  |
| database.postgresql.resources.limits.cpu | string | `"2000m"` |  |
| database.postgresql.resources.limits.memory | string | `"4Gi"` |  |
| database.postgresql.resources.requests.cpu | string | `"1000m"` |  |
| database.postgresql.resources.requests.memory | string | `"2Gi"` |  |
| database.postgresql.resources.requests.cpu | string | `"500m"` |  |
| database.postgresql.resources.requests.memory | string | `"1Gi"` |  |
| osc-minio.enable | bool | `true` |  |
| osc-minio.minio.fullnameOverride | string | `"osc-mlflow-minio"` |  |
| osc-minio.minio.defaultBuckets | string | `"mlflow-artifacts"` |  |
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
| mlflow.commonLabels.receiver | string | `"{{ index .Values.global.alert.receiver }}"` |  |
| mlflow.commonLabels."{{ include "osc.common.serviceAccountKey" . }}" | string | `"{{ include \"osc.common.serviceAccountValue\" . }}"` |  |
| mlflow.nodeSelector."{{ include "osc.common.nodeSelectorRoleKey" . }}" | string | `""` |  |
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
| mlflow.backendStore.postgres.host | string | `"{{ .Release.Name }}-postgresql"` |  |
| mlflow.backendStore.postgres.port | int | `5432` |  |
| mlflow.backendStore.postgres.database | string | `"{{ .Values.global.postgresql.auth.database }}"` |  |
| mlflow.backendStore.postgres.driver | string | `"psycopg2"` |  |
| mlflow.backendStore.postgres.user | string | `"{{ .Values.global.postgresql.auth.username }}"` |  |
| mlflow.backendStore.postgres.password | string | `"{{ .Values.global.postgresql.auth.password }}"` |  |
| mlflow.artifactRoot.proxiedArtifactStorage | bool | `true` |  |
| mlflow.artifactRoot.defaultArtifactRoot | string | `"./mlruns"` |  |
| mlflow.artifactRoot.defaultArtifactsDestination | string | `"s3://mlflow-artifacts/"` |  |
| mlflow.ingress.enabled | bool | `true` |  |
| mlflow.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt"` |  |
| mlflow.ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"true"` |  |
| mlflow.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` |  |
| mlflow.ingress.hosts[0].host | string | `"{{ .Values.global.ingress.host }}"` |  |
| mlflow.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| mlflow.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| mlflow.ingress.tls[0].secretName | string | `"osc-mlflow-cert"` |  |
| mlflow.ingress.tls[0].hosts[0] | string | `"{{ .Values.global.ingress.host }}"` |  |
| mlflow.extraEnvVars.AWS_DEFAULT_REGION | string | `"us-east-1"` |  |
| mlflow.extraEnvVars.MLFLOW_S3_ENDPOINT_URL | string | `"http://osc-mlflow-minio:9000"` |  |
| mlflow.extraEnvVars.MLFLOW_DEFAULT_ARTIFACT_ROOT | string | `"s3://mlflow-artifacts/"` |  |
| mlflow.extraSecretNamesForEnvFrom[0] | string | `"osc-mlflow-app-secrets"` |  |
| mlflow.auth.enabled | bool | `true` |  |
| mlflow.auth.adminUsername | string | `"{{ .Values.global.mlflow.auth.adminUsername }}"` |  |
| mlflow.auth.adminPassword | string | `"{{ .Values.global.mlflow.auth.adminPassword }}"` |  |
| mlflow.auth.postgres.enabled | bool | `true` |  |
| mlflow.auth.postgres.host | string | `"{{ .Release.Name }}-postgresql"` |  |
| mlflow.auth.postgres.port | int | `5432` |  |
| mlflow.auth.postgres.database | string | `"{{ .Values.global.postgresql.auth.database }}"` |  |
| mlflow.auth.postgres.user | string | `"{{ .Values.global.postgresql.auth.username }}"` |  |
| mlflow.auth.postgres.password | string | `"{{ .Values.global.postgresql.auth.password }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
