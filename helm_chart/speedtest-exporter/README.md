# Description
Helm chart which installs speedtest-exporter app in Kubernetes cluster (https://github.com/MiguelNdeCarvalho/speedtest-exporter), optionally adds dashboard for grafana and pod/service monitor if prometheus stack is installed in the same cluster. 

# Variables
| Variable | Description | Default | Required | Versions | 
|--|--|--|--|--|
| replicaCount | Number of pods in the repliceset. Makes sense if deployment is used (speedTestDaemonSet=false, see bellow) | No | 0.0.1 |
| image.repository | Image repo | ghcr.io/miguelndecarvalho/speedtest-exporter | No | 0.0.1 |
| image.pullPolicy | Image pull policy | IfNotPresent | No | 0.0.1 |
| image.tag | Image tag, defaults to appVersion in Chart.yaml | "" | No | 0.0.1 |
| imagePullSecrets | Image pull secrets | [] | No | 0.0.1 |
| nameOverride | name override | "" | No | 0.0.1 |
| fullnameOverride | full name override | "" | No | 0.0.1 |
| speedTestServer | Speedtest server, will be set as ${SPEEDTEST_SERVER} environment (reference - https://docs.miguelndecarvalho.pt/projects/speedtest-exporter/) | "" | No | 0.0.1 |
| speedTestPort | Speedtest port (reference - https://docs.miguelndecarvalho.pt/projects/speedtest-exporter/) | 9798 | No | 0.0.1 |
| speedTestTimeout | For how long the test should run. Sets ${SPEEDTEST_TIMEOUT} environment for the exporter app. | 90 | No | 0.0.1 |
| speedTestDaemonSet | If true, the chart will install daemonset instead of deployment | false | No | 0.0.1 |
| PrometheusMonitor.enabled | If true, will add PodMonitor or ServiceMonitor CRD for metrics discovery (depending on the value of PrometheusMonitor.type, see bollow) custom resource definition| false | No | 0.0.1 |
| PrometheusMonitor.type | The type of the CRD to be added. Only service and pod are valid values. | service | Yes, if PrometheusMonitor.enabled is true| 0.0.1 |
| PrometheusMonitor.scrapeInterval | Prometheus scrape interval | 10m | No | 0.0.1 |
| PrometheusMonitor.scrapeTimeout | Prometheus scrape timeout | 91s | No | 0.0.1 |
| PrometheusMonitor.annotations | Annotations to be added to the CRD | {} | No | 0.0.1 |
| PrometheusMonitor.additionalLabels | Additional labels to be added to the CRD | {} | No | 0.0.1 |
| PrometheusMonitor.additionalConfig | Additional configuration for the CRD. Will be added as is to .spec.endpoints[] or .spec.podMetricsEndpoints[] respectively (reference https://docs.openshift.com/container-platform/4.6/rest_api/monitoring_apis/servicemonitor-monitoring-coreos-com-v1.html and https://docs.openshift.com/container-platform/4.6/rest_api/monitoring_apis/podmonitor-monitoring-coreos-com-v1.html)| [] | No | 0.0.1 |
| PrometheusRules.enabled | If true PrometheusRule resource will be added | false | No | 0.0.1 |
| PrometheusRules.rules | PrometheusRule definition. | [] | Yes, if PrometheusRules.enabled is true and no threshold are defined | 0.0.1 |
| PrometheusRules.jitter_threshold | Jitter threshold in ms. Can be used instead of defining PrometheusRules.rules, it will create a simple prometheus rule. | "" | Yes, if PrometheusRules.enabled is true and no rules are defined | 0.0.1 |
| PrometheusRules.ping_threshold | Ping threshold in ms. Can be used instead of defining PrometheusRules.rules, it will create a simple prometheus rule. | "" | Yes, if PrometheusRules.enabled is true and no rules are defined | 0.0.1 |
| PrometheusRules.download_threshold | Download speed threshold in Mbit/s. Can be used instead of defining PrometheusRules.rules, it will create a simple prometheus rule.  | "" | Yes, if PrometheusRules.enabled is true and no rules are defined | 0.0.1 |
| PrometheusRules.upload_threshold | Upload speed threshold in Mbit/s. Can be used instead of defining PrometheusRules.rules, it will create a simple prometheus rule. | "" | Yes, if PrometheusRules.enabled is true and no rules are defined | 0.0.1 |
| PrometheusRules.period | The value will be set to "for" parameter of the PrometheusRule resource | "" | No | 0.0.1 |
| PrometheusRules.additionalLabels | Additional labels to be added to the CRD | {} | No | 0.0.1 |
| PrometheusRules.annotations | Annotations to be added to the CRD | {} | No | 0.0.1 |
| grafanaNamespace | If defined a configmap with grafana dashboard will be created in this namespace | "" | No | 0.0.1 |
| podAnnotations | k8s annotations to be added to the pods |{} | No | 0.0.1 |
| podSecurityContext | Pod security context | {} | No | 0.0.1 |
| securityContext | Container security context | {} | No | 0.0.1 |
| resources | Resources spec | {} | No | 0.0.1 |
| nodeSelector | Node selector | {} | No | 0.0.1 |
| tolerations | Tolerations | [] | No | 0.0.1 |
| affinity | Affinity | {} | No | 0.0.1 |




# Installation
Install/update the chart with the following command

    helm  upgrade --reset-values --install --create-namespace --namespace "${NAMESPACE}" ${RELEASE_NAME} speedtest-exporter/ -f /path/to/your_values.yaml

