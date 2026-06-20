ARG VERSION=1.2.0
FROM nvcr.io/nvidia/ai-dynamo/vllm-runtime:$VERSION
LABEL maintainer='Trey Dockendorf <tdockendorf@osc.edu>'

USER root
RUN apt-get update && apt-get install -y less vim && rm -rf /var/lib/apt/lists/*
#RUN uv pip install --no-cache fastsafetensors
# Patch from https://github.com/ai-dynamo/dynamo/issues/10695#issuecomment-4699899546
COPY patch-10165.py .
ARG VERSION=1.2.0
RUN python3 patch-10165.py $VERSION
# Patch from https://github.com/ai-dynamo/dynamo/pull/10248/changes
COPY patch-10248.py .
ARG VERSION=1.2.0
RUN python3 patch-10248.py $VERSION
RUN groupadd -g 4097 PZS0645 && \
    usermod -u 52162 -g 4097 dynamo && \
    chown -R dynamo:PZS0645 /home/dynamo
USER dynamo
