FROM rockylinux/rockylinux:9
LABEL maintainer 'Zhi-Qiang You <zyou@osc.edu>'

ARG LICENSE_ID
ARG VERSION
ARG OSC_GROUP
ARG OSC_GID
ARG OSC_USER
ARG OSC_UID

RUN echo $LICENSE_ID
RUN echo $VERSION

RUN dnf update -y && dnf clean all && rm -rf /var/cache/dnf/*
RUN dnf install -y \
	dnf-utils \
	epel-release 

# Add SLURM
RUN dnf config-manager --add-repo https://repo.hpc.osc.edu/internal/slurm/slurm.repo
RUN dnf config-manager --add-repo https://repo.hpc.osc.edu/internal/osc_yum_repo/osc_repo.repo
RUN dnf -y install slurm slurm-spank-lua lua lua-posix \
    && dnf clean all && rm -rf /var/cache/dnf/*
RUN groupadd -r slurm
RUN useradd -r -g slurm -d /var/spool/slurm -s /sbin/nologin slurm

# Add service account
RUN groupadd -g $OSC_GID $OSC_GROUP
RUN mkdir -p /users/$OSC_GROUP
RUN useradd -g $OSC_GROUP -u $OSC_UID -d /users/$OSC_GID/$OSC_USER -m $OSC_USER

# Set up CryoSPARC master
RUN cd /tmp && \
    curl -L https://get.cryosparc.com/download/master-v${VERSION}/${LICENSE_ID} -o cryosparc_master.tar.gz && \
    tar xf cryosparc_master.tar.gz -C /opt
RUN cd /opt/cryosparc_master && ./install.sh --license $LICENSE_ID --hostname localhost --dbpath /opt/cryosparc_database  --port 31000 --yes
RUN cd /opt/cryosparc_master && truncate -s 0 config.sh
RUN chown -R $OSC_USER:$OSC_GROUP /opt/cryosparc_master

USER $OSC_USER
ENV PATH="/opt/cryosparc_master/bin:${PATH}"
WORKDIR /opt/cryosparc_master

