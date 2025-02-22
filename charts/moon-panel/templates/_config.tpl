{{- define "moon-panel-backend.conf" -}}
  [base]
  # Web run port. Default:3002
  http_port=3002
  # Database driver [mysql/sqlite(Default)]
  database_drive=mysql
  # Storage driver [s3/local(Default)]. In local mode, the file path is fixed set '/app/uploads'
  storage_drive=s3

  # optional, valid when database_drive=mysql
  [mysql]
  host={{ .Values.backend.mysql.host}}
  port={{ .Values.backend.mysql.port}}
  username={{ .Values.backend.mysql.username}}
  password={{ .Values.backend.mysql.password}}
  db_name={{ .Values.backend.mysql.db_name}}
  wait_timeout=100

  # optional, valid when database_drive=sqlite
  [sqlite]
  file_path=./database/database.db

  # optional, valid when storage_drive=s3
  [s3]
  access_key_id={{ .Values.backend.s3.access_key_id}}
  secret_access_key={{ .Values.backend.s3.secret_access_key}}
  endpoint={{ .Values.backend.s3.endpoint}}
  bucket={{ .Values.backend.s3.bucket}}
  region={{ .Values.backend.s3.region}}

  [jwt]
  # JWT secret key
  secret={{ .Values.backend.jwt.secret}}
  # JWT token expiration time in hours, default: 72
  expire={{ .Values.backend.jwt.expire}}
{{- end }}