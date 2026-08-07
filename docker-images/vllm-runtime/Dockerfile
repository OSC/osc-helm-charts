ARG FROM=nvcr.io/nvidia/ai-dynamo/vllm-runtime
ARG VERSION=1.3.0
FROM $FROM:$VERSION
LABEL maintainer='Trey Dockendorf <tdockendorf@osc.edu>'

USER root
RUN apt-get update && apt-get install -y less vim && rm -rf /var/lib/apt/lists/*
#RUN uv pip install --no-cache fastsafetensors
# Patch from https://github.com/ai-dynamo/dynamo/issues/10695#issuecomment-4699899546
#COPY patch-10165.py .
#ARG VERSION=1.2.0
#RUN python3 patch-10165.py $VERSION
# Patch from https://github.com/ai-dynamo/dynamo/pull/10248/changes
#COPY patch-10248.py .
#ARG VERSION=1.2.0
#RUN python3 patch-10248.py $VERSION
# Patch from https://github.com/vllm-project/vllm/commit/f9f770ca0b02f8b83ae92997a68efa797611ce36
#COPY vllm-nixl-env-patch.patch vllm-nixl-env-patch.sh .
#ARG VERSION=1.2.0
#RUN bash vllm-nixl-env-patch.sh $VERSION
# Patch from https://github.com/ai-dynamo/dynamo/commit/0b973594e2cac8dfcf826401333a650349abea0c
#COPY 0b973594e2cac8dfcf826401333a650349abea0c.patch .
#COPY patch-1.3.0.sh .
#ARG VERSION=1.2.0
#RUN bash patch-1.3.0.sh $VERSION 0b973594e2cac8dfcf826401333a650349abea0c.patch
RUN groupadd -g 4097 PZS0645 && \
    usermod -u 52162 -g 4097 dynamo && \
    chown -R dynamo:PZS0645 /home/dynamo
USER dynamo
