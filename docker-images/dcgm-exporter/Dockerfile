ARG VERSION
FROM nvcr.io/nvidia/k8s/dcgm-exporter:$VERSION
LABEL maintainer 'Trey Dockendorf <tdockendorf@osc.edu>'

#RUN apt-get update && apt-get install -y ca-certificates
RUN apt-get update && \
    apt-get install -y datacenter-gpu-manager-4-proprietary

ENTRYPOINT ["/usr/local/dcgm/dcgm-exporter-entrypoint.sh"]
