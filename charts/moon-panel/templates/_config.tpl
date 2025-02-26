{{- define "moon-panel-backend.conf" -}}
[base]
# Web run port. Default:3002
http_port=3002
# Database driver [mysql/sqlite(Default)]
database_drive=mysql
# Enable static file server. Default:true
enable_static_server=false
# Used as prefix to generate file url. For example, "/uploads/xxxx.png"
source_path=uploads

# optional, valid when database_drive=mysql
[mysql]
host={{ .Values.backend.mysql.host}}
port={{ .Values.backend.mysql.port}}
username={{ .Values.backend.mysql.username}}
password={{ .Values.backend.mysql.password}}
db_name={{ .Values.backend.mysql.db_name}}
wait_timeout=100

# Use rclone to store files. Both support local and remote storage
[rclone]
type=s3
provider={{ .Values.backend.rclone.provider}}
access_key_id={{ .Values.backend.rclone.access_key_id}}
secret_access_key={{ .Values.backend.rclone.secret_access_key}}
endpoint={{ .Values.backend.rclone.endpoint}}
bucket={{ .Values.backend.rclone.bucket}}
region={{ .Values.backend.rclone.region}}

[jwt]
# JWT secret key
secret={{ .Values.backend.jwt.secret}}
# JWT token expiration time in hours, default: 72
expire={{ .Values.backend.jwt.expire}}
{{- end }}