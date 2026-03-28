{{/*
Expand the name of the chart.
*/}}
{{- define "invoice-ninja.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "invoice-ninja.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart label.
*/}}
{{- define "invoice-ninja.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "invoice-ninja.labels" -}}
helm.sh/chart: {{ include "invoice-ninja.chart" . }}
{{ include "invoice-ninja.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "invoice-ninja.selectorLabels" -}}
app.kubernetes.io/name: {{ include "invoice-ninja.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
