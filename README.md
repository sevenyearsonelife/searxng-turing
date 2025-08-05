# SearXNG 私有化部署

本项目提供了一个基于 Docker 的 SearXNG 元搜索引擎的私有化部署方案。它经过预先配置，旨在提供一个注重隐私、聚合多个搜索引擎结果的搜索服务。

## 项目特点

- **注重隐私**：默认使用 POST 请求，禁用日志记录，保护用户搜索隐私。
- **多引擎聚合**：集成了谷歌、必应、百度、DuckDuckGo 等多个国内外主流搜索引擎。
- **易于部署**：通过简单的脚本即可快速启动、停止和测试服务。
- **高度可配置**：所有关键配置项均在 `searxng/` 目录下，方便按需修改。

## 环境要求

- [Docker](https://www.docker.com/)

## 快速开始

1. **克隆或下载本项目**

2. **启动服务**

   ```bash
   sh run.sh
   ```

   该脚本会自动拉取 `searxng/searxng` 镜像并在后台运行容器。服务将监听在 `http://127.0.0.1:9088`。

3. **访问服务**

   在浏览器中打开 [http://127.0.0.1:9088/](http://127.0.0.1:9088/) 即可开始使用。

## 常用命令

### 服务管理

- **启动服务**
  ```bash
  sh run.sh
  ```

- **停止服务**
  首先找到容器名称：
  ```bash
  docker ps | grep searxng
  ```
  然后停止它：
  ```bash
  docker stop <container_name>
  ```

- **重启服务**
  ```bash
  docker stop <container_name> && sh run.sh
  ```

### 测试服务

你可以使用提供的 `curl.sh` 脚本来测试服务是否正常工作：

```bash
sh curl.sh
```

## 配置说明

所有配置文件都位于 `searxng/` 目录下。

- `searxng/settings.yml`: SearXNG 的核心配置文件。你可以在这里修改启用的搜索引擎、界面语言、搜索结果格式等。
- `searxng/uwsgi.ini`: uWSGI 服务器的配置文件。通常无需修改。

**重要提示**：修改任何配置后，都需要重启服务才能生效。

## 文件结构

```
.
├── run.sh              # 服务启动脚本
├── curl.sh             # 服务测试脚本
├── searxng/            # 配置目录
│   ├── settings.yml    # SearXNG 核心配置
│   └── uwsgi.ini       # uWSGI 服务器配置
└── README.md           # 本文档
```