curl -X POST 'http://10.4.85.77:9088/search' \
     -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0" \
     -H "Accept-Language: zh-CN,zh;q=0.9" \
     -H "Accept: application/json" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     --data-urlencode "q=参加泰国清迈的水灯节，按照当地的习俗和气候，有什么特别的穿搭建议？" \
     --data-urlencode "format=json" \
     --data-urlencode "language=zh-CN" \
     --data-urlencode "engines=google,duckduckgo,brave,360search,baidu,quark" \
     --data-urlencode "categories=general" \
     --data-urlencode "time_range=year" \
     --data-urlencode "timeout_limit=8" | jq

