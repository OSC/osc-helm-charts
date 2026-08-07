ARG FROM=ghcr.io/open-webui/open-webui
ARG VERSION=0.10.2
FROM $FROM:$VERSION
LABEL maintainer='Trey Dockendorf <tdockendorf@osc.edu>'

USER root
# RUN apt-get update && apt-get install -y less vim && rm -rf /var/lib/apt/lists/*

ARG PATCH=c5b147ec6b11ae29f5d61b321a24125eefcec92b
RUN cd /tmp && curl -L -O https://github.com/OSC/open-webui/commit/$PATCH.patch && \
    cd /app && patch -p1 < /tmp/$PATCH.patch
RUN groupadd -g 4097 PZS0645 && \
    useradd -u 52162 -g 4097 -d /home/dynamo -m dynamo
# COPY openai.py /app/backend/open_webui/routers/
# RUN chown -R dynamo /app/backend/open_webui/routers
ENV HOME=/home/dynamo
# ENV GLOBAL_LOG_LEVEL=DEBUG
