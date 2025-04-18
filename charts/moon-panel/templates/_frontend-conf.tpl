{{- define "moon-panel-frontend.conf" -}}
# 定义缓存区域（用于静态文件）
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=static_cache:10m max_size=1g inactive=60m;

# 自定义日志格式，包含缓存状态
log_format cache_log '$remote_addr - $remote_user [$time_local] '
										 '"$request" $status $body_bytes_sent '
										 '"$http_referer" "$http_user_agent" '
										 'cache: $upstream_cache_status';

server {
    listen 80;
    server_name localhost;

    root /usr/share/nginx/html;
    index index.html;
    client_max_body_size 10M;

    access_log /var/log/nginx/access.log cache_log;

    # 支持 React Router
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API 请求转发到后端
    location /api/ {
        proxy_pass http://svc-moon-panel-backend:3002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # 静态文件请求，走缓存
    location /uploads/ {
        proxy_pass http://svc-moon-panel-backend:3002/api/file/s3/;
        proxy_cache static_cache;
        proxy_cache_valid 200 24h;
        proxy_cache_key "$scheme$request_method$host$request_uri";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        # 添加缓存状态头
        add_header X-Cache-Status $upstream_cache_status;

        # 添加 Cache-Control 头部, 缓存1天
        add_header Cache-Control "public, max-age=86400";
    }

    # 额外配置静态站点
    location /site/ {
        proxy_pass http://svc-moon-panel-site:3001/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

}
{{- end }}