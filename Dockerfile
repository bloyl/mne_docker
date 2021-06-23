FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

ARG USER="mne_user"
ARG HOME_DIR="/home/${USER}"
ENV USER=${USER}
ENV HOME_DIR=${HOME_DIR}

ARG CONDA_DIR="${HOME_DIR}/miniconda3"

# install xvfb
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y xvfb wget && \
    apt-get install -y qt5-default && \
    rm -rf /var/lib/apt/lists/*

# setup entry point
COPY entry.sh /sbin/entry.sh
RUN chmod a+x /sbin/entry.sh

# setup mne user
RUN useradd -ms /bin/bash -d ${HOME_DIR} ${USER}
USER $USER
WORKDIR $HOME_DIR

# setup conda
ENV PATH="${CONDA_DIR}/bin:${PATH}"
ARG PATH="${CONDA_DIR}/bin:${PATH}"
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh ./Miniconda3-latest-Linux-x86_64.sh -b -p ${CONDA_DIR} && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh && \
    conda init
SHELL ["/bin/bash", "--login", "-c"]

# install mne
RUN wget https://raw.githubusercontent.com/mne-tools/mne-python/main/environment.yml && \
    conda env update --name base --file environment.yml && \
    rm -f ./environment.yml

# download mne sample data
RUN python -c "import mne; mne.datasets.sample.data_path()"

# copy test scripts
RUN mkdir mne_tests
COPY mne_tests/test*.py mne_tests/

# make output directory for testing purposes
RUN mkdir -p ${HOME_DIR}/output

# setup environment for mne
# MNE_3D_OPTION_ANTIALIAS is needed to avoid blank screenshots.
# PYVISTA_OFF_SCREEN=true is *NOT* needed
ENV \
    MNE_3D_BACKEND=pyvista \
    MNE_3D_OPTION_ANTIALIAS=false

ENTRYPOINT ["entry.sh"]
CMD ["/bin/bash"]
