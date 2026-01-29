ARG VERSION
FROM bitnamilegacy/minio:$VERSION as minio-docker
FROM docker.io/bitnami/minideb:bookworm
LABEL maintainer 'Samuel Khuvis <skhuvis@osc.edu>'

COPY --from=minio-docker / /
SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]
ENV APP_VERSION="2025.10.15" \
    BITNAMI_APP_NAME="minio" \
    IMAGE_REVISION="6" \
    PATH="/opt/bitnami/minio-client/bin:/opt/bitnami/minio/bin:$PATH"

EXPOSE 9000 9001

WORKDIR /opt/bitnami/minio-client
USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/minio/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/minio/run.sh" ]
