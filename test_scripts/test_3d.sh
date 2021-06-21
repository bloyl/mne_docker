#!/bin/bash

conda create -y --name mne python=3.8

conda activate mne
pip install pyvista matplotlib
pip install -U git+https://github.com/GuillaumeFavelier/mne-python.git@proto/off_screen

mne sys_info
MNE_3D_BACKEND=offscreen PYVISTA_OFF_SCREEN=true python ../work/plot_eeg_on_scalp.py
