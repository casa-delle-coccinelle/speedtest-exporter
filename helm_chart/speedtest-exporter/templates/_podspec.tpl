{{- define "pod_spec" -}}
{{ if not .Values.speedTestDaemonSet }}
replicas: {{ .Values.replicaCount }}
{{ end }}
selector:
  matchLabels:
    {{- include "speedtest-exporter.selectorLabels" . | nindent 6 }}
template:
  metadata:
    {{- with .Values.podAnnotations }}
    annotations:
      {{- toYaml . | nindent 8 }}
    {{- end }}
    labels:
      {{- include "speedtest-exporter.selectorLabels" . | nindent 8 }}
  spec:
    {{- with .Values.imagePullSecrets }}
    imagePullSecrets:
      {{- toYaml . | nindent 8 }}
    {{- end }}
    securityContext:
      {{- toYaml .Values.podSecurityContext | nindent 8 }}
    containers:
      - name: {{ .Chart.Name }}
        securityContext:
          {{- toYaml .Values.securityContext | nindent 12 }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        envFrom:
          - configMapRef:
              name: {{ include "speedtest-exporter.fullname" . }}
        ports:
          - name: http
            containerPort: {{ .Values.speedTestPort }}
            protocol: TCP
        livenessProbe:
          tcpSocket:
            port: http
        readinessProbe:
          httpGet:
            path: /
            port: http
        resources:
          {{- toYaml .Values.resources | nindent 12 }}
    {{- with .Values.nodeSelector }}
    nodeSelector:
      {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.affinity }}
    affinity:
      {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.tolerations }}
    tolerations:
      {{- toYaml . | nindent 8 }}
    {{- end }}
{{- end }}
