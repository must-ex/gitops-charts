{{/*
Chart name
*/}}
{{- define "datadog.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels — includes version, managed-by; use for metadata.labels
*/}}
{{- define "datadog.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "datadog.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — stable across upgrades.
*/}}
{{- define "datadog.selectorLabels" -}}
app.kubernetes.io/name: {{ include "datadog.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
