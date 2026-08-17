{{/*
Chart name
*/}}
{{- define "finora-ex.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels — includes version, managed-by; use for metadata.labels
*/}}
{{- define "finora-ex.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "finora-ex.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — stable across upgrades; used in matchLabels and pod template labels.
Component label is added per-resource alongside these.
*/}}
{{- define "finora-ex.selectorLabels" -}}
app.kubernetes.io/name: {{ include "finora-ex.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name
*/}}
{{- define "finora-ex.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "finora-ex.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
