# Helm Charts Repository

<!-- language -->
[English](README.md) | [简体中文](README_zh-CN.md)

This repository contains a collection of well-maintained Helm Charts for quickly deploying common services to Kubernetes clusters.

## 📦 Available Charts

### blinko
- **Description**: Lightweight self-hosted documentation system
- **Use Case**: Rapid deployment of basic web applications

### grafana-stack
- **Description**: All-in-one monitoring solution
- **Includes**:
  - Grafana dashboards
  - Prometheus for metrics
  - Tempo for traces
  - Agent Operator for auto-collection

### keycloak
- **Description**: Enterprise-grade Identity and Access Management solution
- **Architecture**: Highly available StatefulSet deployment
- **Features**:
  - Automatic database initialization
  - Cluster mode configuration

### my-traefik
- **Description**: Production-ready reverse proxy/Ingress controller
- **Key Features**:
  - CertManager integration
  - Automatic TLS certificate renewal
  - Pre-configured middleware
  - Wildcard domain support
  - Custom CRD support

### umami
- **Description**: Modern website analytics platform
- **Features**:
  - Lightweight deployment
  - PostgreSQL integration

## 🚀 Quick Start

1. Add the repository to Helm:
```bash
helm repo add phantom-lab https://phantommaa.github.io/charts
helm repo update
```

2. Install a chart (example for grafana-stack):
```bash
helm install grafana-stack phantom-lab/grafana-stack \
  --namespace monitoring \
  --create-namespace
```

## ⚙️ Usage Examples
View configurable parameters for a chart:
```bash
helm show values phantom-lab/grafana-stack
```

Custom installation with values file:
```bash
helm install -f custom-values.yaml grafana-stack phantom-lab/grafana-stack
```

## 📄 License
MIT License - See [LICENSE](LICENSE) file
