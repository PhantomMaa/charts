# Helm Chart 仓库

本仓库包含一系列精心维护的 Helm Chart，用于快速部署常用服务到 Kubernetes 集群。

## 📦 可用 Chart 列表

### blinko
- **描述**: 轻量级 自部署的文档系统
- **适用场景**: 快速部署基础 Web 应用

### grafana-stack
- **描述**: Grafana 全家桶
- **包含**:
  - Grafana 仪表盘
  - Prometheus Metrics
  - Loki Log
	- Tempo Trace
	- agent operator 自动采集

### keycloak
- **描述**: 企业级身份认证与访问管理解决方案
- **架构**: 高可用 StatefulSet 部署
- **支持**:
  - 数据库自动初始化
  - 集群模式配置

### my-traefik
- **描述**: 生产级反向代理/Ingress 控制器
- **核心功能**:
  - CertManager 集成
  - 自动 TLS 证书续期
  - 预置常用中间件
  - 支持泛域名
  - 自定义 CRD 支持

### umami
- **描述**: 现代网站分析平台
- **特性**:
  - 轻量级部署
  - PostgreSQL 数据库集成

## 🚀 快速开始

1. 添加仓库到 Helm：
```bash
helm repo add phantom-lab https://phantommaa.github.io/charts
helm repo update
```

2. 安装 Chart（示例安装 grafana-stack）：
```bash
helm install grafana-stack phantom-lab/grafana-stack \
  --namespace monitoring \
  --create-namespace
```

## ⚙️ 使用示例
查看特定 Chart 的可配置参数：
```bash
helm show values phantom-lab/grafana-stack
```

自定义安装（使用 values 文件）：
```bash
helm install -f custom-values.yaml grafana-stack phantom-lab/grafana-stack
```

## 📄 许可证
MIT License - 详见 [LICENSE](LICENSE) 文件
