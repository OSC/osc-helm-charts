FROM docker-registry.osc.edu/osc/slurm-25.05-rhel9:latest
LABEL maintainer 'Zhi-Qiang You <zyou@osc.edu>'
ARG LICENSE_ID
ARG VERSION

RUN echo $LICENSE_ID
RUN echo $VERSION

RUN cd /tmp && \
    curl -L https://get.cryosparc.com/download/master-v${VERSION}/${LICENSE_ID} -o cryosparc_master.tar.gz && \
    tar xf cryosparc_master.tar.gz -C /opt

RUN cd /opt/cryosparc_master && ./install.sh --license $LICENSE_ID --hostname localhost --dbpath /opt/cryosparc_database  --port 31000 --yes

RUN cd /opt/cryosparc_master && truncate -s 0 config.sh

RUN rm -rf /tmp/*

ENV PATH="/opt/cryosparc_master/bin:${PATH}"
WORKDIR /opt/cryosparc_master
