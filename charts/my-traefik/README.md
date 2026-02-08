# My Traefik

[![Helm Version](https://img.shields.io/badge/Helm-v3-blue)](https://helm.sh)
[![Traefik Version](https://img.shields.io/badge/Traefik-v3.5-blue)](https://traefik.io)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A Helm chart for deploying Traefik with automatic HTTPS certificate management using cert-manager integration.

## Features

- One-click deployment of Traefik as an ingress controller
- Automatic HTTPS certificate management (requires cert-manager to be installed)
- Support for wildcard domain certificates
- Cloudflare DNS challenge integration
- Optional basic authentication support
- Cross-namespace support for ingress resources

## Prerequisites

- Kubernetes cluster
- Helm v3+
- cert-manager installed in the cluster (required for HTTPS support)
- A domain name with Cloudflare DNS management (for HTTPS)
- Cloudflare API token with DNS management permissions (for HTTPS)

## Installation

1. Install cert-manager (if not already installed):
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.yaml
```

2. Add the Helm repository:
```bash
helm repo add phantom-chart "https://phantommaa.github.io/charts"
helm repo update
```

3. Create a values.yaml file with your configuration:
```yaml
config:
  domain: your-domain.com
  https:
    enabled: true
    cloudflareApiToken: your-cloudflare-api-token
    email: your-email@example.com
  auth:
    enabled: false  # Set to true if you want basic authentication

traefik:
  providers:
    kubernetesCRD:
      enabled: true
      allowCrossNamespace: true
      namespaces:
        - default
        - your-namespace
```

4. Install the chart:
```bash
helm install my-traefik my-traefik/my-traefik -f values.yaml
```

## Configuration

### Required Values

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.domain` | Your domain name | `nil` |
| `config.https.enabled` | Enable HTTPS with cert-manager | `true` |
| `config.https.cloudflareApiToken` | Cloudflare API token for DNS challenge | `nil` |
| `config.https.email` | Email for Let's Encrypt registration | `nil` |

### Optional Values

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.auth.enabled` | Enable basic authentication | `false` |
| `traefik.providers.kubernetesCRD.allowCrossNamespace` | Allow cross-namespace ingress | `true` |
| `traefik.providers.kubernetesCRD.namespaces` | List of namespaces to watch | `["default"]` |

## Components

This Helm chart deploys:
- Traefik (v3.5.0) - Modern reverse proxy and load balancer
- cert-manager resources (Certificate, Issuer, etc.) - when HTTPS is enabled

## Architecture

The chart sets up Traefik as an ingress controller. When HTTPS is enabled, it creates cert-manager resources (ClusterIssuer, Certificate) to automatically manage HTTPS certificates using Let's Encrypt with Cloudflare DNS challenge.

**Note:** cert-manager must be installed separately in your cluster before enabling HTTPS in this chart.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
