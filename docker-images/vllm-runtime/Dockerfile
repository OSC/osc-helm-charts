ARG VERSION
FROM nvcr.io/nvidia/ai-dynamo/vllm-runtime:$VERSION
LABEL maintainer 'Trey Dockendorf <tdockendorf@osc.edu>'

USER root
RUN groupadd -g 4097 PZS0645 && \
    usermod -u 52162 -g 4097 dynamo && \
    chown -R dynamo:PZS0645 /home/dynamo
USER dynamo
