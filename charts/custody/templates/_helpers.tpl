{{/*
Chart name
*/}}
{{- define "custody.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels — includes version, managed-by; use for metadata.labels
*/}}
{{- define "custody.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "custody.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — stable across upgrades; used in matchLabels and pod template labels.
Component label is added per-resource alongside these.
*/}}
{{- define "custody.selectorLabels" -}}
app.kubernetes.io/name: {{ include "custody.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name
*/}}
{{- define "custody.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "custody.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
