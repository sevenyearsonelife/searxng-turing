# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SearXNG meta-search engine deployment configured to run on a specific server instance. The project provides a privacy-focused search interface that aggregates results from multiple search engines.

## Architecture

The project consists of:
- **Docker-based deployment**: Uses the official `searxng/searxng` image
- **Custom configuration**: Mounts local settings to override defaults
- **Network-specific setup**: Configured for the Turing server environment
- **Service scripts**: Provides easy startup and testing utilities

## Key Configuration

### Network Settings
- **Server**: 10.4.85.77 (Turing instance)
- **Port**: 9088 (external) → 8080 (internal container)
- **Base URL**: http://10.4.85.77:9088/
- **Instance Name**: "turing-instance"

### SearXNG Configuration (searxng/settings.yml)
- **Default engines**: Google, Bing, Baidu, DuckDuckGo, Brave, 360Search, Quark (enabled)
- **Output formats**: HTML and JSON
- **Search method**: POST (for privacy)
- **Language**: Auto-detect with Chinese support
- **Safe search**: Disabled (level 0)
- **Time range**: Year-limited searches
- **Timeout**: 8 seconds per engine

### uWSGI Configuration (searxng/uwsgi.ini)
- **Workers**: Auto-detected based on CPU cores
- **Threads**: 4 per worker
- **Process management**: Master mode with lazy apps
- **Static files**: Served by uWSGI with gzip compression
- **Logging**: Disabled for privacy, only 5xx errors logged

## Common Commands

### Service Management
```bash
# Start the service
sh run.sh

# Stop the service (use actual container name from docker ps)
docker stop <container_name>

# Check service status
docker ps | grep searxng

# Restart the service
docker stop <container_name> && sh run.sh
```

### Testing the Service
```bash
# Test search via curl (Chinese query example)
sh curl.sh

# Manual curl test
curl -X POST 'http://10.4.85.77:9088/search' \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "q=test query" \
  --data-urlencode "format=json"

# Web interface access
open http://10.4.85.77:9088/
```

### Configuration Management
```bash
# Edit SearXNG settings
nano searxng/settings.yml

# Edit uWSGI configuration
nano searxng/uwsgi.ini

# After configuration changes, restart service
docker stop <container_name> && sh run.sh
```

## Development Notes

### Engine Configuration
- The configuration includes both Chinese and international search engines
- Many engines are disabled by default to reduce load and improve response times
- Engine timeouts and suspension times are configured for reliability
- The service supports time-range limited searches (past year)

### Privacy Features
- POST requests prevent search terms from appearing in logs
- Request logging is disabled in uWSGI
- No tracking cookies or user profiling
- Image proxy is disabled but can be enabled if needed

### Performance Considerations
- Concurrent connection limits: 100 connections, 20 max pool size
- HTTP/2 is enabled for better performance
- Request timeout: 3 seconds default, with engine-specific overrides
- Rate limiting is disabled for this private instance

## File Structure
```
.
├── run.sh              # Service startup script
├── curl.sh             # Test script with example search
└── searxng/            # Configuration directory
    ├── settings.yml    # Main SearXNG configuration
    └── uwsgi.ini       # uWSGI server configuration
```

## Deployment Specifics

This instance is configured for:
- **Environment**: Turing server (10.4.85.77)
- **Use case**: Private meta-search engine
- **Language focus**: Chinese and English content
- **Access**: Internal network access only
- **Maintenance**: Docker container management