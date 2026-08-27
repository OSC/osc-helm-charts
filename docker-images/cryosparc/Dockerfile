FROM docker-registry.osc.edu/osc/slurm-25.05-rhel9:latest
LABEL maintainer 'Zhi-Qiang You <zyou@osc.edu>'
ARG LICENSE_ID
ARG VERSION

RUN echo $LICENSE_ID
RUN echo $VERSION

# Tools for diagnostics
RUN dnf install -y iproute procps-ng && \
    dnf clean all && rm -rf /var/cache/dnf/*

RUN cd /tmp && \
    curl -L https://get.cryosparc.com/download/master-v${VERSION}/${LICENSE_ID} -o cryosparc_master.tar.gz && \
    tar xf cryosparc_master.tar.gz -C /opt && \
    rm -rf /tmp/*

RUN if [ -f /opt/cryosparc_master/install/install_master.sh ]; then \
        sed -i 's/check_and_offer_patch_install$/# check_and_offer_patch_install/g' /opt/cryosparc_master/install/install_master.sh; \
    else \
        echo "install/install_master.sh not found, skipping patch check removal"; \
    fi 

RUN cd /opt/cryosparc_master && \
    ./install.sh --license $LICENSE_ID --hostname localhost --dbpath /opt/cryosparc_database --port 31000 --yes \
    truncate -s 0 config.sh && \
    rm -rf database run lanes && \
    ln -s /cryosparc_data/database database && \
    ln -s /cryosparc_data/run run && \
    ln -s /cryosparc_data/lanes lanes


ENV PATH="/opt/cryosparc_master/bin:${PATH}"
WORKDIR /opt/cryosparc_master
