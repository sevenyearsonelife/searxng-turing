# CLAUDE.zh.md

该文件为 Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 项目概述

这是一个 SearXNG 元搜索引擎部署，配置为在特定服务器实例上运行。该项目提供了一个注重隐私的搜索界面，可聚合来自多个搜索引擎的结果。

## 架构

该项目包括：
- **基于 Docker 的部署**：使用官方 `searxng/searxng` 镜像
- **自定义配置**：挂载本地设置以覆盖默认值
- **特定于网络的设置**：为图灵服务器环境配置
- **服务脚本**：提供简单的启动和测试实用程序

## 关键配置

### 网络设置
- **服务器**：10.4.85.77 (图灵实例)
- **端口**：9088 (外部) → 8080 (内部容器)
- **基础 URL**：http://10.4.85.77:9088/
- **实例名称**："turing-instance"

### SearXNG 配置 (searxng/settings.yml)
- **默认引擎**：谷歌、必应、百度、DuckDuckGo、Brave、360搜索、夸克 (已启用)
- **输出格式**：HTML 和 JSON
- **搜索方法**：POST (为了隐私)
- **语言**：自动检测并支持中文
- **安全搜索**：禁用 (级别 0)
- **时间范围**：一年内的搜索
- **超时**：每个引擎 8 秒

### uWSGI 配置 (searxng/uwsgi.ini)
- **工作进程**：根据 CPU 内核数自动检测
- **线程**：每个工作进程 4 个
- **进程管理**：主模式与延迟加载应用
- **静态文件**：由 uWSGI 提供并启用 gzip 压缩
- **日志记录**：为保护隐私已禁用，仅记录 5xx 错误

## 常用命令

### 服务管理
```bash
# 启动服务
sh run.sh

# 停止服务 (使用 docker ps 中的实际容器名称)
docker stop <container_name>

# 检查服务状态
docker ps | grep searxng

# 重启服务
docker stop <container_name> && sh run.sh
```

### 测试服务
```bash
# 通过 curl 测试搜索 (中文查询示例)
sh curl.sh

# 手动 curl 测试
curl -X POST 'http://10.4.85.77:9088/search' \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "q=test query" \
  --data-urlencode "format=json"

# 访问 Web 界面
open http://10.4.85.77:9088/
```

### 配置管理
```bash
# 编辑 SearXNG 设置
nano searxng/settings.yml

# 编辑 uWSGI 配置
nano searxng/uwsgi.ini

# 修改配置后，重启服务
docker stop <container_name> && sh run.sh
```

## 开发说明

### 引擎配置
- 配置包括中文和国际搜索引擎
- 默认禁用许多引擎以减少负载并提高响应时间
- 为确保可靠性，配置了引擎超时和暂停时间
- 该服务支持时间范围限制的搜索 (过去一年)

### 隐私功能
- POST 请求可防止搜索词出现在日志中
- uWSGI 中禁用了请求日志记录
- 无跟踪 cookie 或用户分析
- 图像代理已禁用，但如果需要可以启用

### 性能考量
- 并发连接限制：100 个连接，最大池大小 20
- 启用 HTTP/2 以获得更好的性能
- 请求超时：默认为 3 秒，可针对特定引擎进行覆盖
- 此私有实例禁用了速率限制

## 文件结构
```
.
├── run.sh              # 服务启动脚本
├── curl.sh             # 带示例搜索的测试脚本
└── searxng/            # 配置目录
    ├── settings.yml    # 主要 SearXNG 配置
    └── uwsgi.ini       # uWSGI 服务器配置
```

## 部署详情

此实例配置用于：
- **环境**：图灵服务器 (10.4.85.77)
- **用例**：私有元搜索引擎
- **语言重点**：中文和英文内容
- **访问**：仅限内部网络访问
- **维护**：Docker 容器管理