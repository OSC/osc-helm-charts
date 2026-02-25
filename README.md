# osc-helm-charts

Charts for deploying OSC specific Kubernetes services using Helm

## Table of Contents
- [Charts](#charts)
  - [osc-common](#osc-common)
  - [webservice](#webservice)
  - [osc-open-webui](#osc-open-webui)
  - [database](#database)
- [Helm Chart Values Patterns](#helm-chart-values-patterns)
  - [Environment-Specific Values](#environment-specific-values)
- [Infrastructure charts](#infrastructure-charts)
  - [prometheus](#prometheus)
  - [kubernetes-dashboard-proxy](#kubernetes-dashboard-proxy)
  - [paas](#paas)
  - [kyverno-policies](#kyverno-policies)
- [Docker Images](#docker-images)
  - [Adding New Docker Images](#adding-new-docker-images)

## Charts

Charts under [charts](./charts/) directory are either parent charts for deployments at OSC, or infrastructure charts.

The [osc-common](#osc-common) chart is intended to be used by all OSC charts to provide helpers and baseline.

The other non-infrastructure charts are used to deploy services at OSC and often those services are defined under [charts-private](./charts-private/).  Some parent charts require minimal inputs and can be deployed directly to OSC rather than using [charts-private](./charts-private/).

### osc-common
The [osc-common](charts/osc-common/README.md) chart is a foundational Helm chart that provides common resources and configuration patterns used across all OSC Helm charts. It defines shared helpers, labels, and configurations that ensure consistency in deployments. This chart creates:

- Common labels and selectors used throughout OSC deployments
- Service account configurations with proper labeling
- Node selector role configurations
- Image pull secrets for accessing OSC's private registry
- Network policies for controlling pod communication
- Role bindings for debug, maintenance, and port-forwarding operations
- Shared helper templates for consistent deployment patterns

This chart is a dependency for most other charts in this repository and ensures that all deployments follow OSC's standard practices for security, labeling, and resource management.

### webservice
The [webservice](charts/webservice/README.md) chart is a bootstrap chart for OSC web services. It includes:

- Basic web service deployment patterns
- Integration with database chart for data persistence
- Integration with osc-common for consistent configurations

### osc-open-webui
The [osc-open-webui](charts/osc-open-webui/README.md) chart deploys the Open Web UI with OSC-specific configurations. It includes:

- Integration with osc-common for consistent configurations
- Integration with the open-webui Helm chart for the actual UI deployment

### database
The [database](charts/database/README.md) chart provides database service deployments with support for multiple database types:

- MariaDB
- MongoDB
- PostgreSQL
- Redis

It includes integration with osc-common for consistent security and configuration practices.

## Helm Chart Values Patterns

When using the OSC Puppet infrastructure, some values are automatically added to Helm charts, particularly for webservices.

For easier deployments it's best to rely on these auto-generated values when writing Helm charts.

Common values added

```yaml
global:
  environment: production  # or test, etc.
  imagePullSecret:
    password: <pull_secret_value>
```

All non-infrastructure services deployed at OSC need to set the service account that will run the service.

```yaml
global:
  oscServiceAccount: <username>
```

Webservice specific values when `webservice => true` is set:

```yaml
webservice:
  ingress:
    host: <name>.<env k8 domain>
    hostAlias: <name>.osc.edu
```

Authentication values when `keycloak_auth => true` is set:

```yaml
webservice:
  auth:
    idpHost: <ENV specific IDP host>
    clientID: kubernetes-<name>-production
    clientSecret: <secret_value>
    cookieSecret: <cookie_value>
```

Global webservice configuration when `webservice_key => global` is set:

```yaml
global:
  ingress:
    host: <name>.<env k8 domain>
    hostAlias: <name>.osc.edu
  auth: # if keycloak_auth => true
    idpHost: <ENV specific IDP host>
    clientID: kubernetes-<name>-production
    clientSecret: <secret_value>
    cookieSecret: <cookie_value>
```

### Environment-Specific Values

Environment-specific values are configured using the `global.env` section in Helm chart values. The example from [charts-private/emthub/values.yaml](./charts-private/emthub/values.yaml) shows how to set different configurations for different environments:

```yaml
global:
  imageTag: v0.1.0
  env:
    production:
      replicas: 2
      image:
        tag: '{{ .Values.global.imageTag }}'
    test:
      replicas: 2
      image:
        tag: '{{ .Values.global.imageTag }}'
    dev:
      replicas: 1
      image:
        tag: latest
      podResources:
        limits:
          cpu: 2
          memory: 2Gi
        requests:
          cpu: 500m
          memory: 265Mi
```

Note that the `dev` environment should the only environment using `tag: latest` as it's intended for development purposes. Production and test environments should use tagged versions for consistency and stability.

## Infrastructure charts

### prometheus
The [prometheus](charts/prometheus) chart deploys Prometheus monitoring solution with OSC-specific configurations. It includes:

- Prometheus server with OSC-specific settings
- kube-state-metrics for Kubernetes resource metrics
- dcgm-exporter for GPU metrics (when applicable)
- Integration with osc-common for consistent configuration

### kubernetes-dashboard-proxy
The [kubernetes-dashboard-proxy](charts/kubernetes-dashboard-proxy) chart deploys a proxy for accessing the Kubernetes Dashboard with OSC-specific configurations.

### paas
The [paas](charts/paas/README.md) chart provides a bootstrap Helm chart for OSC's Platform as a Service deployments. It includes:

- Basic PaaS infrastructure setup
- Integration with osc-common for consistent configurations

### kyverno-policies
The [kyverno-policies](charts/kyverno-policies) chart deploys Kyverno policies for Kubernetes cluster management with OSC-specific configurations.

## Docker Images

Docker images are built under the [docker-images](./docker-images/) directory for some of the charts managed by OSC. These images include:

- [dcgm-exporter](./docker-images/dcgm-exporter/) - NVIDIA DCGM exporter for GPU metrics
- [mariadb](./docker-images/mariadb/) - MariaDB database image
- [postgresql](./docker-images/postgresql/) - PostgreSQL database image
- [nominatim](./docker-images/nominatim/) - Nominatim geocoding service image
- [postgresql-nominatim](./docker-images/postgresql-nominatim/) - PostgreSQL image with Nominatim support

These images are used by various Helm charts in this repository and are built with OSC-specific configurations and security standards.

### Adding New Docker Images

To add a new docker image build, follow this pattern:

1. Create a new directory under [docker-images](./docker-images/) with the name of your image
2. Add a [Dockerfile](./docker-images/postgresql/Dockerfile) in that directory with your image definition
3. Add a [Makefile](./docker-images/postgresql/Makefile) in that directory with build, push, and kind-load targets
4. Update the [release_docker.yaml](.github/workflows/release_docker.yaml) workflow to include your new image in the matrix
5. Update the [test.yaml](.github/workflows/test.yaml) workflow to build and load your image before chart tests

Example structure:
```
docker-images/
└── example-image/
    ├── Dockerfile
    └── Makefile
```

The Makefile should include targets for building, pushing, and loading the image into kind:
```
build:
	docker build --build-arg VERSION=$(VERSION) -t $(TAG) $(ROOT_DIR)

push:
	docker push $(TAG)

kind-load:
	kind load docker-image $(TAG)
```

The workflow will automatically detect changes to your image directory and build/push it when changes are pushed to the main branch. The test workflow will also build and load your image into the kind cluster before running chart tests.
