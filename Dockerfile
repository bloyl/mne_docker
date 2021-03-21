FROM jupyter/base-notebook:python-3.8.6

USER root
RUN apt-get update \
 && apt-get install  -yq --no-install-recommends \
    libgl1-mesa-glx libglib2.0-0 libxkbcommon-x11-0 \
    libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-randr0 libxcb-render-util0 libxcb-xinerama0 \
    libxcb-xfixes0 libopengl0 libglu1-mesa libgl1-mesa-dri xvfb \
    git make \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

USER jovyan

# setup the conda environment
COPY environment.yml labextensions.txt ./
RUN wget https://raw.githubusercontent.com/mne-tools/mne-python/main/server_environment.yml \
      && conda run conda install -y -c conda-forge conda-merge \
      && conda-merge server_environment.yml environment.yml > this_env.yml \
      && conda env update --name base --file  this_env.yml \
      && conda run conda install -y nodejs \
      && conda run jupyter labextension install $(cat ./labextensions.txt) \
      && conda clean --all -f -y 

      # && pip install ipyvtk-simple==0.1.2 \

# install mne sample data...
RUN python -c "import mne; mne.datasets.sample.data_path()"


# allow jupyterlab for ipyvtk
ENV DISPLAY=:99.0
ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_USE_IPYVTK=true
ENV PYVISTA_OFF_SCREEN=true

# modify the CMD and start a background server first
ENTRYPOINT ["tini", "-g", "--", "/entry.sh"]
CMD start-notebook.sh

USER root

COPY entry.sh /
RUN chmod a+x /entry.sh
COPY test_scripts/* ./work/
RUN chmod a+x ./work/*



USER jovyan
