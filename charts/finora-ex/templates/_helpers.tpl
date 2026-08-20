{{/*
Chart name.

This value is NOT free to change on a live release. It lands in selectorLabels
(app.kubernetes.io/name), which is baked into Deployment/StatefulSet spec.selector —
immutable once the object exists — and it also prefixes resource names
(<name>-secret, <name>-migrate, <name>-default-deny, the PrometheusRule, the default
ingress name, the ServiceAccount).

`nameOverride` exists so an environment can hold this string steady while the chart
itself is renamed. finora-ex dev/stg pin it to "exchange", the chart's original name,
so their live objects keep the identity they were created with.
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
