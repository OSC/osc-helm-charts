# osc-helm-charts

Charts for deploying OSC specific Kubernetes services using Helm

## Table of Contents
- [Charts](#charts)
  - [osc-common](#osc-common)
  - [webservice](#webservice)
  - [osc-open-webui](#osc-open-webui)
  - [database](#database)
- [Infrastructure charts](#infrastructure-charts)
  - [prometheus](#prometheus)
  - [kubernetes-dashboard-proxy](#kubernetes-dashboard-proxy)
  - [paas](#paas)
  - [kyverno-policies](#kyverno-policies)

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