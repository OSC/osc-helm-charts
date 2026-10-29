ARG UPSTREAM_FROM=ghcr.io/open-webui/open-webui
ARG UPSTREAM_VERSION=0.12.5-slim
ARG FROM=ghcr.io/osc/open-webui
ARG VERSION=osc-0.12.5-r0-slim

FROM $UPSTREAM_FROM:$UPSTREAM_VERSION AS upstream

RUN pip freeze > /app/backend/requirements-openwebui.txt

FROM $FROM:$VERSION AS base

LABEL maintainer='Trey Dockendorf <tdockendorf@osc.edu>'

COPY --from=upstream /app/backend/requirements-openwebui.txt /app/backend/requirements-openwebui.txt
RUN pip install -r /app/backend/requirements-openwebui.txt

#RUN cd /tmp && curl -L -O https://github.com/OSC/open-webui/commit/$PATCH.patch && \
#    cd /app && patch -p1 < /tmp/$PATCH.patch
#RUN groupadd -g 4097 PZS0645 && \
#    useradd -u 52162 -g 4097 -d /home/dynamo -m dynamo
# COPY openai.py /app/backend/open_webui/routers/
# RUN chown -R dynamo /app/backend/open_webui/routers
#ENV HOME=/home/dynamo
# ENV GLOBAL_LOG_LEVEL=DEBUG
