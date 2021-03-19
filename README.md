## MNE Docker

The goal of the repository is to have a full MNE environment within a docker container. This should include full 2d/3d support, and optially that parts of freesurfer that are accessible via mne.

This was originally based off pyvista's docker then incorporated things from mne/tools/start_xvfb.sh, and other various places.

**This is currently a WIP.**

Also this readme is abit of a core dump sorry.

;-----

The current situation is that mne is installed using the`server_environment.yml' and is accessible via both juypter and from the command line.

Assuming you have it build and named as mne_docker

jupyter lab is available via:
```
docker run -p 8888:8888 mne_docker
```
and then accessing via your browser. I'm not sure how to get rid of the jupyter token access, which does get annoying.

To get to a shell use:

```
docker run -it mne_docker bash
```
or if you want root (to be able to install packages etc)
```
docker run -it -e GRANT_SUDO=yes --user root mne_docker bash
```

I suspect that once this is working I may restructure it to have a non juypter container and one that adds juypter on top. That will depend on how big it all is.

### What works.
I think everything works except for the 3D visualization. I plan on having a script that sets up mne trunk and runs both tests and doc, to more fully see what is working. *Is there a way to do that against the installed version of mne not development version?*

I'm not sure how best to get 3d plotting to work.
currently mne sys_info return

```
$docker run -it mne_docker mne sys_info

Platform:      Linux-5.8.0-45-generic-x86_64-with-glibc2.10
Python:        3.8.8 | packaged by conda-forge | (default, Feb 20 2021, 16:22:27)  [GCC 9.3.0]
Executable:    /opt/conda/bin/python
CPU:           x86_64: 4 cores
Memory:        Unavailable (requires "psutil" package)
mne:           0.22.0
numpy:         1.20.1 {blas=NO_ATLAS_INFO, lapack=lapack}
scipy:         1.6.1
matplotlib:    3.3.4 {backend=Qt5Agg}

sklearn:       0.24.1
numba:         Not found
nibabel:       3.2.1
nilearn:       0.7.1
dipy:          Not found
cupy:          Not found
pandas:        1.2.3
mayavi:        Not found
pyvista:       0.29.0 {OpenGL 3.3 (Core Profile) Mesa 18.3.1 via llvmpipe (LLVM 7.0, 256 bits)}
vtk:           9.0.0
PyQt5:         5.15.4
```

and 
```
$ docker run mne_docker python -c "import pyvista; pl=pyvista.Plotter(); print(pl.ren_win.ReportCapabilities())"

OpenGL vendor string:
```

and finally,
```
$ docker run -it mne_docker python work/plot_eeg_on_scalp.py
Opening raw data file /home/jovyan/mne_data/MNE-sample-data/MEG/sample/sample_audvis_raw.fif...
    Read a total of 3 projection items:
        PCA-v1 (1 x 102)  idle
        PCA-v2 (1 x 102)  idle
        PCA-v3 (1 x 102)  idle
    Range : 25800 ... 192599 =     42.956 ...   320.670 secs
Ready.
Using outer_skin.surf for head surface.
Using pyvista 3d backend.

qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, webgl, xcb.
```

simlar code run in juypter crashes the kernel.

