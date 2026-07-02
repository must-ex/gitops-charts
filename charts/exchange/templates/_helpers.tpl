{{/*
Chart name
*/}}
{{- define "exchange.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels — includes version, managed-by; use for metadata.labels
*/}}
{{- define "exchange.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "exchange.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — stable across upgrades; used in matchLabels and pod template labels.
Component label is added per-resource alongside these.
*/}}
{{- define "exchange.selectorLabels" -}}
app.kubernetes.io/name: {{ include "exchange.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name
*/}}
{{- define "exchange.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "exchange.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
