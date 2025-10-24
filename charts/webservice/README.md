# webservice

![Version: 0.37.1](https://img.shields.io/badge/Version-0.37.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

OSC webservice bootstrap Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| treydock |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://osc.github.io/osc-helm-charts/ | database | 0.9.0 |
| https://osc.github.io/osc-helm-charts/ | osc-common | 0.7.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imagePullSecret.name | string | `"osc-registry"` |  |
| global.imagePullSecret.registry | string | `"docker-registry.osc.edu"` |  |
| global.imagePullSecret.username | string | `"robot$webservices-read"` |  |
| global.imagePullSecret.password | string | `nil` |  |
| global.nodeSelectorRole | string | `"webservices"` |  |
| global.storageClass | string | `"webservices-nfs-client"` |  |
| appType | string | `"rails"` |  |
| command | list | `[]` |  |
| args | list | `[]` |  |
| workingDir | string | `nil` |  |
| env | list | `[]` |  |
| defaultCommand.rails[0] | string | `"bundle"` |  |
| defaultCommand.rails[1] | string | `"exec"` |  |
| defaultCommand.rails[2] | string | `"passenger"` |  |
| defaultCommand.rails[3] | string | `"start"` |  |
| defaultCommand.rshiny[0] | string | `"/bin/passenger"` |  |
| defaultCommand.rshiny[1] | string | `"start"` |  |
| defaultCommand.none | list | `[]` |  |
| defaultArgs.rails[0] | string | `"--min-instances=1"` |  |
| defaultArgs.rails[1] | string | `"--sticky-sessions"` |  |
| defaultArgs.rails[2] | string | `"--start-timeout=180"` |  |
| defaultArgs.rails[3] | string | `"--environment=production"` |  |
| defaultArgs.rails[4] | string | `"--disable-security-update-check"` |  |
| defaultArgs.rails[5] | string | `"--disable-anonymous-telemetry"` |  |
| defaultArgs.rails[6] | string | `"--log-file=/dev/stdout"` |  |
| defaultArgs.rails[7] | string | `"--pid-file=/tmp/passenger-{{ .name }}.pid"` |  |
| defaultArgs.rshiny[0] | string | `"--min-instances=1"` |  |
| defaultArgs.rshiny[1] | string | `"--sticky-sessions"` |  |
| defaultArgs.rshiny[2] | string | `"--start-timeout=180"` |  |
| defaultArgs.rshiny[3] | string | `"--environment=production"` |  |
| defaultArgs.rshiny[4] | string | `"--disable-security-update-check"` |  |
| defaultArgs.rshiny[5] | string | `"--disable-anonymous-telemetry"` |  |
| defaultArgs.rshiny[6] | string | `"--log-file=/dev/stdout"` |  |
| defaultArgs.rshiny[7] | string | `"--pid-file=/tmp/passenger-{{ .name }}.pid"` |  |
| defaultArgs.rshiny[8] | string | `"--app-start-command"` |  |
| defaultArgs.rshiny[9] | string | `"{{ .startCommand | default \"R --no-save --slave -f /app/entrypoint.R --args $$PORT\" }}"` |  |
| defaultArgs.none | list | `[]` |  |
| containers[0].name | string | `"{{ include \"webservice.name\" . }}"` |  |
| containers[0].port | string | `nil` |  |
| containers[0].portName | string | `"http"` |  |
| containers[0].startCommand | string | `nil` |  |
| containers[0].probePath | string | `nil` |  |
| containers[0].probeType | string | `nil` |  |
| containers[0].ingressPath | string | `"/"` |  |
| containers[0].auth | string | `nil` |  |
| image.repository | string | `nil` |  |
| image.tag | string | `nil` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| mounts.home | string | `""` |  |
| mounts.roDir | object | `{}` |  |
| mounts.socket | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podResources.limits.cpu | int | `4` |  |
| podResources.limits.memory | string | `"4Gi"` |  |
| podResources.requests.cpu | int | `1` |  |
| podResources.requests.memory | string | `"256Mi"` |  |
| podDistributionBudget.minAvailable | int | `1` |  |
| secrets | object | `{}` |  |
| envSecrets | object | `{}` |  |
| debugGroups | list | `[]` |  |
| alert.receiver | string | `nil` |  |
| service.port | int | `3000` |  |
| service.annotations | object | `{}` |  |
| service.typeAnnotations.rshiny."prometheus.io/probe_module" | string | `"http"` |  |
| service.typeAnnotations.rshiny."prometheus.io/probe_scheme" | string | `"http"` |  |
| probes.type | string | `nil` |  |
| probes.path | string | `"/"` |  |
| probes.typeDefaults.rshiny | string | `"tcpSocket"` |  |
| startupProbe.httpGet.path | string | `"{{ .probePath | default .Values.probes.path }}"` |  |
| startupProbe.httpGet.port | string | `"{{ .portName | default .name }}"` |  |
| startupProbe.tcpSocket.port | string | `"{{ .portName | default .name }}"` |  |
| startupProbe.failureThreshold | int | `12` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| livenessProbe.httpGet.path | string | `"{{ .probePath | default .Values.probes.path }}"` |  |
| livenessProbe.httpGet.port | string | `"{{ .portName | default .name }}"` |  |
| livenessProbe.tcpSocket.port | string | `"{{ .portName | default .name }}"` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| readinessProbe.httpGet.path | string | `"{{ .probePath | default .Values.probes.path }}"` |  |
| readinessProbe.httpGet.port | string | `"{{ .portName | default .name }}"` |  |
| readinessProbe.tcpSocket.port | string | `"{{ .portName | default .name }}"` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| initContainers | object | `{}` |  |
| init.podResources.limits.cpu | int | `1` |  |
| init.podResources.limits.memory | string | `"1Gi"` |  |
| init.podResources.requests.cpu | string | `"200m"` |  |
| init.podResources.requests.memory | string | `"256Mi"` |  |
| ingress.host | string | `""` |  |
| ingress.hostAlias | string | `""` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"8k"` |  |
| ingress.rShinyAnnotations."nginx.ingress.kubernetes.io/proxy-read-timeout" | string | `"86400"` |  |
| ingress.rShinyAnnotations."nginx.ingress.kubernetes.io/proxy-send-timeout" | string | `"3600"` |  |
| ingress.rShinyAnnotations."nginx.ingress.kubernetes.io/server-snippets" | string | `"location / {\n  proxy_http_version 1.1;\n  proxy_set_header Upgrade $http_upgrade;\n  proxy_set_header Connection $connection_upgrade;\n  proxy_buffering off;\n }\n"` |  |
| auth.enable | bool | `true` |  |
| auth.clientID | string | `"kubernetes-{{ include \"webservice.name\" . }}"` |  |
| auth.clientSecret | string | `nil` |  |
| auth.cookieSecret | string | `nil` |  |
| auth.cookieName | string | `"_{{ include \"osc.common.serviceAccountValue\" . }}{{ include \"osc.common.environment\" . }}"` |  |
| auth.idpHost | string | `nil` |  |
| auth.oidcIssuerURL | string | `"https://$(IDP_HOST)/realms/osc"` |  |
| auth.allowGroups | string | `nil` |  |
| auth.skipAuthRoute | string | `nil` |  |
| auth.image.repository | string | `"quay.io/oauth2-proxy/oauth2-proxy"` |  |
| auth.image.tag | string | `"v7.1.3"` |  |
| auth.image.pullPolicy | string | `"IfNotPresent"` |  |
| auth.service.port | int | `4180` |  |
| auth.service.annotations."prometheus.io/probe_module" | string | `"http-healthz"` |  |
| auth.service.annotations."prometheus.io/probe_path" | string | `"/ping"` |  |
| auth.metricsService.type | string | `"ClusterIP"` |  |
| auth.metricsService.port | int | `8080` |  |
| auth.metricsService.annotations."prometheus.io/scrape" | string | `"true"` |  |
| auth.metricsService.annotations."prometheus.io/path" | string | `"/metrics"` |  |
| auth.podResources.limits.cpu | string | `"200m"` |  |
| auth.podResources.limits.memory | string | `"128Mi"` |  |
| auth.podResources.requests.cpu | string | `"100m"` |  |
| auth.podResources.requests.memory | string | `"64Mi"` |  |
| auth.ingress.className | string | `nil` |  |
| auth.ingress.annotations."prometheus.io/probe_path" | string | `"/ping"` |  |
| auth.podDistributionBudget.minAvailable | int | `1` |  |
| data.enable | bool | `false` |  |
| data.storageClass | string | `"{{ .Values.global.storageClass }}"` |  |
| data.storageSize | string | `"10Gi"` |  |
| data.path | string | `"/data"` |  |
| database.enable | bool | `false` |  |
| database.imagePullSecret.enable | bool | `false` |  |
| database.host | string | `"{{ include \"webservice.name\" . }}-mariadb"` |  |
| database.user | string | `"{{ .Values.database.mariadb.auth.username }}"` |  |
| database.password | string | `"{{ .Values.database.mariadb.auth.password }}"` |  |
| database.name | string | `"{{ .Values.database.mariadb.auth.database }}"` |  |
| database.url | string | `"mysql2://{{ tpl .Values.database.user . }}:$(DATABASE_PASSWORD)@{{ tpl .Values.database.host . }}:3306/{{ tpl .Values.database.name . }}"` |  |
| database.mariadb.enable | bool | `false` |  |
| database.mariadb.networkPolicy.ingressRules.primaryAccessOnlyFrom.podSelector."app.kubernetes.io/name" | string | `"{{ include \"webservice.name\" . }}"` |  |
| database.postgresql.enable | bool | `false` |  |
| database.postgresql.networkPolicy.ingressRules.primaryAccessOnlyFrom.podSelector."app.kubernetes.io/name" | string | `"{{ include \"webservice.name\" . }}"` |  |
| hook.image.repository | string | `"docker-registry.osc.edu/kubernetes/bitnami/kubectl"` |  |
| hook.image.tag | string | `"1.27.14"` |  |
| ingressName | string | `"ingress-nginx"` |  |
| prometheusName | string | `"prometheus"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
