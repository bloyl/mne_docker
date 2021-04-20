FROM frolvlad/alpine-miniconda3:latest

RUN apk update

# Dependencies for xvfb
RUN apk add \
    build-base \
    libx11-dev \ 
    libxcursor-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxi-dev \
    mesa-dev \
    mesa-dri-gallium \
    xvfb-run \
    bash \
    git

# setup user
RUN addgroup -S mne_group && adduser -S mne_user -G mne_group

# setup base conda environment
RUN conda update python && \
    conda install -c conda-forge pyvistaqt pyvista

# install mne
RUN wget https://raw.githubusercontent.com/mne-tools/mne-python/main/environment.yml && \
    conda env update --name base --file environment.yml

# install mne-testing
RUN wget https://raw.githubusercontent.com/mne-tools/mne-python/main/requirements_testing.txt && \
    pip install -r requirements_testing.txt

COPY entry.sh /sbin/entry.sh
RUN chmod a+x /sbin/entry.sh

# copy test scripts
COPY test_scripts/* ./mne_test/
RUN chown -R mne_user:mne_group ./mne_test && \
    chmod a+x ./mne_test/*

# Tell docker that all future commands should run as the appuser user
USER mne_user

# get mne sample data
RUN python -c "import mne; mne.datasets.sample.data_path()"

ENV \
    DISPLAY=":99" \
    XVFB_WHD="1920x1080x24" \
    PYVISTA_OFF_SCREEN=true \
    MNE_3D_BACKEND=pyvista

ENTRYPOINT ["entry.sh"]
CMD ["/bin/bash"]
    
USER root
RUN apk add git
USER mne_user
