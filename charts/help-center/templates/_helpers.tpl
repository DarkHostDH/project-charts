{{/* vim: set filetype=mustache: */}}

{{- define "project.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "project.fullname" -}}
{{- printf "%s-%s" .Chart.Name .Values.projectEnv | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "project.labels" -}}
helm.sh/chart: {{ include "project.chart" . }}
{{ include "project.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* ------------------------Selector labels------------------------- */}}
{{- define "project.selectorLabels" -}}
app.kubernetes.io/name: {{ include "project.name" . }}
app.kubernetes.io/instance: {{ .Values.projectEnv }}
{{- end -}}


{{/* ----------Create the name of the service account to use---------- */}}
{{- define "project.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "project.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
