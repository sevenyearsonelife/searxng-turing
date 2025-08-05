#!/bin/bash

# 优化的SearXNG搜索脚本
# 包含反爬虫策略和错误处理

# 配置参数
SEARXNG_URL="http://10.4.85.77:9088/search"
QUERY="参加泰国清迈的水灯节，按照当地的习俗和气候，有什么特别的穿搭建议？"

# 随机User-Agent池（模拟不同浏览器）
USER_AGENTS=(
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0"
)

# 随机选择User-Agent
RANDOM_UA=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}

echo "🔍 开始搜索..."
echo "📱 使用User-Agent: $RANDOM_UA"
echo "🌐 查询内容: $QUERY"
echo ""

# 执行优化的curl请求
curl -X POST "$SEARXNG_URL" \
     -H "User-Agent: $RANDOM_UA" \
     -H "Accept: application/json, text/plain, */*" \
     -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" \
     -H "Accept-Encoding: gzip, deflate" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -H "Origin: http://10.4.85.77:9088" \
     -H "Referer: http://10.4.85.77:9088/" \
     -H "DNT: 1" \
     -H "Connection: keep-alive" \
     -H "Sec-Fetch-Dest: empty" \
     -H "Sec-Fetch-Mode: cors" \
     -H "Sec-Fetch-Site: same-origin" \
     --data-urlencode "q=$QUERY" \
     --data-urlencode "format=json" \
     --data-urlencode "language=zh-CN" \
     --data-urlencode "engines=duckduckgo,brave,360search,baidu,quark,google" \
     --data-urlencode "categories=general" \
     --data-urlencode "time_range=year" \
     --data-urlencode "timeout_limit=10" \
     --connect-timeout 15 \
     --max-time 30 \
     --retry 2 \
     --retry-delay 3 \
     --compressed \
     --silent \
     --show-error | jq 

