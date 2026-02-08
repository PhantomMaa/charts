# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 仓库概述

这是一个 Helm Charts 仓库，包含用于常见服务的生产级 Kubernetes 部署配置。该仓库发布为 Helm 仓库，地址为 `https://phantommaa.github.io/charts`。

## 可用 Charts

- **blinko**: 轻量级自托管文档系统 (v1.0.1)
- **grafana-stack**: 包含 Grafana、Prometheus、Tempo 和 Agent Operator 的综合监控解决方案 (v1.0.1)
- **keycloak**: 企业级身份和访问管理，使用 StatefulSet 部署
- **my-traefik**: 生产级反向代理,支持 HTTPS 和 Cloudflare DNS (v1.0.9)
- **umami**: 现代网站分析平台
- **memos**: 笔记应用程序
- **maybe**: 预算跟踪应用程序
- **mcp-gateway**: MCP 网关服务
- **mcp-webpage-to-s3**: 网页到 S3 转换服务
- **gemini-balance**: Gemini 余额查询服务

## Chart 架构

### Chart 结构
每个 chart 都遵循标准 Helm 约定：
```
charts/<chart-name>/
├── Chart.yaml          # Chart 元数据和依赖项
├── values.yaml         # 默认配置值
├── templates/
│   ├── _helpers.tpl    # 模板助手和通用函数
│   ├── deployment.yaml # 应用程序部署
│   ├── service.yaml    # Kubernetes 服务
│   └── ingressroute.yaml # Traefik 路由（大部分 charts）
└── README.md           # Chart 特定文档
```

### 关键模式

1. **Traefik 集成**: 大多数 charts 使用 Traefik IngressRoute 而非标准 Ingress
2. **模板助手**: 用于命名、标签和选择器的标准 Helm 助手函数
3. **Chart 依赖**: 复杂的 charts 如 `grafana-stack` 使用子 chart 依赖
4. **资源管理**: 所有 charts 都包含资源请求/限制配置

### 重要 Chart 详情

**my-traefik**:
- 基于 Traefik v3.5.0 的反向代理
- 当启用 HTTPS 时,会创建 cert-manager 相关资源(Certificate、Issuer 等)
- 通过 Cloudflare DNS 质询支持通配符域名证书
- 包含基本认证中间件配置
- 默认启用跨命名空间 ingress 支持
- 注意: 需要在集群中预先安装 cert-manager

**grafana-stack**:
- 捆绑 Prometheus (v27.1.0)、Grafana (v8.8.5)、Tempo 和 Grafana Agent Operator
- 预配置 Keycloak OAuth 集成
- 使用外部 MySQL 数据库进行 Grafana 持久化
- 包含完整的数据源配置

## 开发命令

### 测试 Charts
```bash
# 检查特定 chart
helm lint charts/<chart-name>

# 模板渲染测试
helm template <release-name> charts/<chart-name> --values charts/<chart-name>/values.yaml

# 本地安装 chart 进行测试
helm install <release-name> charts/<chart-name> --namespace <namespace> --create-namespace
```

### Chart 依赖管理
```bash
# 更新 chart 依赖（适用于有依赖的 charts）
helm dependency update charts/<chart-name>

# 构建 chart 依赖
helm dependency build charts/<chart-name>
```

### 仓库管理
```bash
# 打包 chart 用于仓库
helm package charts/<chart-name>

# 更新仓库索引
helm repo index .
```

## 配置模式

### 通用 Values 结构
- `image`: 容器镜像配置（repository、tag、pullPolicy）
- `service`: Kubernetes 服务配置（port、type）
- `resources`: CPU/内存请求和限制
- `nameOverride`/`fullnameOverride`: Chart 命名自定义
- Chart 特定配置位于顶级键下（如 `traefik:`、`grafana:`、`prometheus:`）

### 安全注意事项
- 敏感值（密码、令牌）使用占位符值如 "xxx" 标记
- 基本认证凭据使用 Base64 编码
- 生产部署建议使用外部密钥管理
- 数据库连接通常引用外部服务

## 发布

仓库发布到 GitHub Pages 作为 Helm 仓库。Charts 应在提交前进行本地测试，因为更改会自动发布。