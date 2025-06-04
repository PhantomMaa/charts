{{/*
Expand the name of the chart.
*/}}
{{- define "moon-box.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "moon-box.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "moon-box.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "moon-box.labels-backend" -}}
helm.sh/chart: {{ include "moon-box.chart" . }}
{{ include "moon-box.selectorLabels-backend" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "moon-box.labels-frontend" -}}
helm.sh/chart: {{ include "moon-box.chart" . }}
{{ include "moon-box.selectorLabels-frontend" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "moon-box.labels-site" -}}
helm.sh/chart: {{ include "moon-box.chart" . }}
{{ include "moon-box.selectorLabels-site" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "moon-box.selectorLabels-backend" -}}
app.kubernetes.io/name: {{ include "moon-box.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}-backend
{{- end }}

{{- define "moon-box.selectorLabels-frontend" -}}
app.kubernetes.io/name: {{ include "moon-box.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}-frontend
{{- end }}

{{- define "moon-box.selectorLabels-site" -}}
app.kubernetes.io/name: {{ include "moon-box.name" . }}-site
app.kubernetes.io/instance: {{ .Release.Name }}-site
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "moon-box.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "moon-box.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
