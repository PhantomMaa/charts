# My Traefik

[![Helm Version](https://img.shields.io/badge/Helm-v3-blue)](https://helm.sh)
[![Traefik Version](https://img.shields.io/badge/Traefik-v2.10-blue)](https://traefik.io)
[![Cert Manager Version](https://img.shields.io/badge/Cert_Manager-v1.16-blue)](https://cert-manager.io)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A Helm chart that combines Traefik and cert-manager for easy deployment of Traefik with automatic HTTPS certificate management.

## Features

- One-click deployment of Traefik as an ingress controller
- Automatic HTTPS certificate management with cert-manager
- Support wildcard domain names
- Built-in Cloudflare DNS integration
- Optional basic authentication support
- Cross-namespace support for ingress resources

## Prerequisites

- Kubernetes cluster
- Helm v3+
- A domain name with Cloudflare DNS management
- Cloudflare API token with DNS management permissions

## Installation

1. Add the Helm repository:
```bash
helm repo add phantom-chart "https://g-lelp9461-helm.pkg.coding.net/default/phantom-chart"
helm repo update
```

2. Create a values.yaml file with your configuration:
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

3. Install the chart:
```bash
helm install my-traefik my-traefik/my-traefik -f values.yaml
```

## How to build
```bash
helm dependency build .
helm package .
helm coding-push my-traefik-1.x.x.tgz phantom-chart
```

## Publish new version
```bash
git tag -a v1.0.2 -m "Release v1.0.2"
git push origin v1.0.2
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

This Helm chart includes the following components:
- Traefik (v2.x) - Modern reverse proxy and load balancer
- cert-manager - Kubernetes certificate management controller

## Architecture

The chart sets up Traefik as an ingress controller and configures cert-manager to automatically manage HTTPS certificates using Let's Encrypt with Cloudflare DNS challenge.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
