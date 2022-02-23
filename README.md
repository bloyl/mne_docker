# Info
This repository has been completely superseded by https://github.com/mne-tools/mne-docker

I would suggest looking there for inspirational and starting points for docker/singularity images.


# MNE Docker

The goal of the repository is to have a full [MNE](https://mne.tools/stable/index.html) environment within a docker container.
To this includes supporting two funtionalities
- [x] Full headless 2d/3d support with the ability to screenshot and use `mne.report`
- [ ] Support for jupyter lab

**This is currently a WIP.**

## Building instructions
Two Dockerfiles are supplied. The first (`Dockerfile`) builds the core mne environment. The second (`Dockerfile.test`) installs the development version of `mne` to facilitate testing.

### Building the base mne_docker image
`docker build -t mne_docker .`

This can take a long time, particulalry for conda to 'solve the environment'.

Basic plot testing. Both need output directory. so make it (`mkdir output`) if needed.

0)
    ```
    $ docker run -it mne_docker mne sys_info
    QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-mne_user'
    Platform:      Linux-5.8.0-55-generic-x86_64-with-glibc2.17
    Python:        3.8.10 (default, Jun  4 2021, 15:09:15)  [GCC 7.5.0]
    Executable:    /home/mne_user/miniconda3/bin/python3.8
    CPU:           x86_64: 4 cores
    Memory:        19.0 GB

    mne:           0.23.0
    numpy:         1.21.0 {blas=NO_ATLAS_INFO, lapack=lapack}
    scipy:         1.6.3
    matplotlib:    3.4.2 {backend=Qt5Agg}

    sklearn:       0.24.2
    numba:         0.53.1
    nibabel:       3.2.1
    nilearn:       0.8.0
    dipy:          1.4.1
    cupy:          Not found
    pandas:        1.2.5
    mayavi:        4.7.2
    pyvista:       0.31.2 {pyvistaqt=0.5.0, OpenGL 4.5 (Core Profile) Mesa 20.2.6 via llvmpipe (LLVM 11.0.0, 256 bits)}
    vtk:           9.0.1
    PyQt5:         5.12.3
    ```
1) Simple mne brain plot
    ```
    $ docker run -it -v `pwd`/output:/home/mne_user/output mne_docker python mne_tests/test_mne_brain.py output/mne_brain.png
    
    Using pyvista 3d backend.

    QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-mne_user'
    <pyvistaqt.plotting.BackgroundPlotter object at 0x7f5e8567aaf0>
    min:0 - max:232
 
    ```

2) Make mne Reports
    ```
    $ docker run -it -v `pwd`/output:/home/mne_user/output mne_docker python mne_tests/test_mne_report.py output/mne_rpt.html
    ```

Output files (`mne_brain.png`, `mne_rpt.html`) are in `output` directory.


### Building the **testing** mne_docker image
This depends on the above image. So build it first, and then

`docker build -t mne_docker_test . -f Dockerfile.test`

#### Run mne tests
`$ docker run -it mne_docker_test mne_tests/launch_mne_tests.sh`
<details><summary>Output</summary>
<p>


```
$ docker run -it mne_docker_test mne_tests/launch_mne_tests.sh
(base) bloyl@gorgas-linux:~/Projects/docker_stuff/mne_docker$ docker run -it mne_docker_test mne_tests/launch_mne_tests.sh
python setup.py build_ext -i
running build_ext
rm -f .coverage
py.test -m 'not ultraslowtest' mne
====================================================================== test session starts ======================================================================
platform linux -- Python 3.8.10, pytest-6.2.4, py-1.10.0, pluggy-0.13.1
rootdir: /home/mne_user/mne-python, configfile: setup.cfg
plugins: cov-2.12.1, harvest-1.10.3, timeout-1.4.2
collecting 196 items                                                                                                                                            QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-mne_user'
collected 3271 items / 2 deselected / 1 skipped / 3268 selected                                                                                                 

mne/annotations.py s                                                                                                                                      [  0%]
mne/dipole.py s                                                                                                                                           [  0%]
mne/epochs.py ss                                                                                                                                          [  0%]
mne/event.py s.                                                                                                                                           [  0%]
mne/filter.py .s..                                                                                                                                        [  0%]
mne/source_estimate.py s                                                                                                                                  [  0%]
mne/beamformer/tests/test_dics.py ................................................................                                                        [  2%]
mne/beamformer/tests/test_lcmv.py ..........................................                                                                              [  3%]
mne/minimum_norm/tests/test_inverse.py .......................................................................                                            [  5%]
mne/viz/tests/test_3d.py ..............                                                                                                                   [  6%]
mne/beamformer/tests/test_dics.py ........                                                                                                                [  6%]
mne/beamformer/tests/test_external.py .....                                                                                                               [  6%]
mne/beamformer/tests/test_lcmv.py ..................................                                                                                      [  7%]
mne/beamformer/tests/test_rap_music.py ...                                                                                                                [  7%]
mne/beamformer/tests/test_resolution_matrix.py .                                                                                                          [  7%]
mne/channels/channels.py s                                                                                                                                [  7%]
mne/channels/tests/test_channels.py ...............                                                                                                       [  8%]
mne/channels/tests/test_interpolation.py ............                                                                                                     [  8%]
mne/channels/tests/test_layout.py ........                                                                                                                [  8%]
mne/channels/tests/test_montage.py .............................
   Normal return from subroutine COBYLA

   NFVALS =  145   F = 1.724216E-03    MAXCV = 0.000000E+00
   X = 7.754594E-04   6.880787E-03   4.739801E-02   9.490771E-02
.
   Normal return from subroutine COBYLA

   NFVALS =  145   F = 1.724216E-03    MAXCV = 0.000000E+00
   X = 7.754594E-04   6.880787E-03   4.739801E-02   9.490771E-02
.
   Normal return from subroutine COBYLA

   NFVALS =  123   F = 1.657480E-03    MAXCV = 0.000000E+00
   X = 7.603066E-04   6.746337E-03   4.647159E-02   9.305285E-02
..................                                                                      [ 10%]
mne/channels/tests/test_standard_montage.py .................................................                                                             [ 11%]
mne/commands/tests/test_commands.py .....s..............                                                                                                  [ 12%]
mne/connectivity/tests/test_effective.py .                                                                                                                [ 12%]
mne/connectivity/tests/test_envelope.py .                                                                                                                 [ 12%]
mne/connectivity/tests/test_spectral.py ...................                                                                                               [ 13%]
mne/connectivity/tests/test_utils.py ..                                                                                                                   [ 13%]
mne/datasets/eegbci/eegbci.py ..                                                                                                                          [ 13%]
mne/datasets/limo/limo.py .                                                                                                                               [ 13%]
mne/datasets/sleep_physionet/age.py .                                                                                                                     [ 13%]
mne/datasets/sleep_physionet/temazepam.py .                                                                                                               [ 13%]
mne/datasets/sleep_physionet/tests/test_physionet.py X..........X.                                                                                        [ 13%]
mne/datasets/tests/test_datasets.py .......                                                                                                               [ 13%]
mne/decoding/receptive_field.py .                                                                                                                         [ 13%]
mne/decoding/tests/test_base.py ...............                                                                                                           [ 14%]
mne/decoding/tests/test_csp.py .......                                                                                                                    [ 14%]
mne/decoding/tests/test_ems.py .                                                                                                                          [ 14%]
mne/decoding/tests/test_receptive_field.py .............                                                                                                  [ 15%]
mne/decoding/tests/test_search_light.py ...                                                                                                               [ 15%]
mne/decoding/tests/test_ssd.py .....                                                                                                                      [ 15%]
mne/decoding/tests/test_time_frequency.py .                                                                                                               [ 15%]
mne/decoding/tests/test_transformer.py .........                                                                                                          [ 15%]
mne/export/tests/test_export.py sss.........                                                                                                              [ 15%]
mne/forward/_make_forward.py s                                                                                                                            [ 15%]
mne/forward/tests/test_field_interpolation.py .......                                                                                                     [ 16%]
mne/forward/tests/test_forward.py .....s..                                                                                                                [ 16%]
mne/forward/tests/test_make_forward.py .s..s...                                                                                                           [ 16%]
mne/gui/tests/test_coreg_gui.py .....                                                                                                                     [ 16%]
mne/gui/tests/test_fiducials_gui.py .                                                                                                                     [ 16%]
mne/gui/tests/test_file_traits.py .....                                                                                                                   [ 17%]
mne/gui/tests/test_kit2fiff_gui.py ..                                                                                                                     [ 17%]
mne/gui/tests/test_marker_gui.py ..                                                                                                                       [ 17%]
mne/inverse_sparse/mxne_optim.py ..                                                                                                                       [ 17%]
mne/inverse_sparse/tests/test_gamma_map.py ..                                                                                                             [ 17%]
mne/inverse_sparse/tests/test_mxne_debiasing.py .                                                                                                         [ 17%]
mne/inverse_sparse/tests/test_mxne_inverse.py .......................                                                                                     [ 18%]
mne/inverse_sparse/tests/test_mxne_optim.py .......                                                                                                       [ 18%]
mne/io/base.py ss                                                                                                                                         [ 18%]
mne/io/pick.py .                                                                                                                                          [ 18%]
mne/io/utils.py .                                                                                                                                         [ 18%]
mne/io/array/tests/test_array.py ...                                                                                                                      [ 18%]
mne/io/artemis123/tests/test_artemis123.py ..                                                                                                             [ 18%]
mne/io/boxy/tests/test_boxy.py ........                                                                                                                   [ 18%]
mne/io/brainvision/tests/test_brainvision.py ...........................                                                                                  [ 19%]
mne/io/bti/tests/test_bti.py ..............                                                                                                               [ 20%]
mne/io/cnt/tests/test_cnt.py ..                                                                                                                           [ 20%]
mne/io/ctf/tests/test_ctf.py ..s..s..                                                                                                                     [ 20%]
mne/io/curry/tests/test_curry.py ..................xx.............                                                                                        [ 21%]
mne/io/edf/edf.py sss                                                                                                                                     [ 21%]
mne/io/edf/tests/test_edf.py ..........................................                                                                                   [ 22%]
mne/io/edf/tests/test_gdf.py .....                                                                                                                        [ 22%]
mne/io/eeglab/tests/test_eeglab.py ...............                                                                                                        [ 23%]
mne/io/egi/tests/test_egi.py .............                                                                                                                [ 23%]
mne/io/eximia/tests/test_eximia.py .                                                                                                                      [ 23%]
mne/io/fieldtrip/tests/test_fieldtrip.py ....................................................                                                             [ 25%]
mne/io/fiff/tests/test_raw_fiff.py .............................................s...................                                                      [ 27%]
mne/io/hitachi/hitachi.py ..                                                                                                                              [ 27%]
mne/io/hitachi/tests/test_hitachi.py ............                                                                                                         [ 27%]
mne/io/kit/tests/test_coreg.py .                                                                                                                          [ 27%]
mne/io/kit/tests/test_kit.py ............                                                                                                                 [ 28%]
mne/io/nedf/tests/test_nedf.py ....                                                                                                                       [ 28%]
mne/io/nicolet/tests/test_nicolet.py .                                                                                                                    [ 28%]
mne/io/nihon/tests/test_nihon.py .                                                                                                                        [ 28%]
mne/io/nirx/tests/test_nirx.py ..................                                                                                                         [ 28%]
mne/io/persyst/tests/test_persyst.py ........                                                                                                             [ 29%]
mne/io/snirf/tests/test_snirf.py ............                                                                                                             [ 29%]
mne/io/tests/test_apply_function.py .                                                                                                                     [ 29%]
mne/io/tests/test_compensator.py .....s                                                                                                                   [ 29%]
mne/io/tests/test_constants.py .......                                                                                                                    [ 29%]
mne/io/tests/test_meas_info.py ....................................                                                                                       [ 31%]
mne/io/tests/test_pick.py ...............................                                                                                                 [ 31%]
mne/io/tests/test_proc_history.py .                                                                                                                       [ 31%]
mne/io/tests/test_raw.py ..............                                                                                                                   [ 32%]
mne/io/tests/test_read_raw.py .........                                                                                                                   [ 32%]
mne/io/tests/test_reference.py .............                                                                                                              [ 33%]
mne/io/tests/test_show_fiff.py .                                                                                                                          [ 33%]
mne/io/tests/test_utils.py .                                                                                                                              [ 33%]
mne/io/tests/test_what.py .                                                                                                                               [ 33%]
mne/io/tests/test_write.py .                                                                                                                              [ 33%]
mne/minimum_norm/tests/test_inverse.py ............                                                                                                       [ 33%]
mne/minimum_norm/tests/test_resolution_matrix.py .                                                                                                        [ 33%]
mne/minimum_norm/tests/test_resolution_metrics.py .                                                                                                       [ 33%]
mne/minimum_norm/tests/test_snr.py s                                                                                                                      [ 33%]
mne/minimum_norm/tests/test_time_frequency.py ................                                                                                            [ 34%]
mne/preprocessing/_peak_finder.py .                                                                                                                       [ 34%]
mne/preprocessing/_regress.py s                                                                                                                           [ 34%]
mne/preprocessing/nirs/tests/test_beer_lambert_law.py ........                                                                                            [ 34%]
mne/preprocessing/nirs/tests/test_nirs.py .............                                                                                                   [ 34%]
mne/preprocessing/nirs/tests/test_optical_density.py ...                                                                                                  [ 34%]
mne/preprocessing/nirs/tests/test_scalp_coupling_index.py ......                                                                                          [ 35%]
mne/preprocessing/nirs/tests/test_temporal_derivative_distribution_repair.py .                                                                            [ 35%]
mne/preprocessing/tests/test_artifact_detection.py ....                                                                                                   [ 35%]
mne/preprocessing/tests/test_csd.py ...                                                                                                                   [ 35%]
mne/preprocessing/tests/test_ctps.py .                                                                                                                    [ 35%]
mne/preprocessing/tests/test_ecg.py .                                                                                                                     [ 35%]
mne/preprocessing/tests/test_eeglab_infomax.py .                                                                                                          [ 35%]
mne/preprocessing/tests/test_eog.py .                                                                                                                     [ 35%]
mne/preprocessing/tests/test_fine_cal.py ....                                                                                                             [ 35%]
mne/preprocessing/tests/test_flat.py ...                                                                                                                  [ 35%]
mne/preprocessing/tests/test_ica.py ..................................................................................................................... [ 39%]
............................                                                                                                                              [ 40%]
mne/preprocessing/tests/test_infomax.py ......                                                                                                            [ 40%]
mne/preprocessing/tests/test_interpolate.py .........                                                                                                     [ 40%]
mne/preprocessing/tests/test_maxwell.py .............................                                                                                     [ 41%]
mne/preprocessing/tests/test_otp.py ..                                                                                                                    [ 41%]
mne/preprocessing/tests/test_peak_finder.py .                                                                                                             [ 41%]
mne/preprocessing/tests/test_realign.py ...........................                                                                                       [ 42%]
mne/preprocessing/tests/test_regress.py .                                                                                                                 [ 42%]
mne/preprocessing/tests/test_ssp.py ......                                                                                                                [ 42%]
mne/preprocessing/tests/test_stim.py .                                                                                                                    [ 42%]
mne/preprocessing/tests/test_xdawn.py .......                                                                                                             [ 42%]
mne/simulation/tests/test_evoked.py ...                                                                                                                   [ 42%]
mne/simulation/tests/test_metrics.py .                                                                                                                    [ 43%]
mne/simulation/tests/test_raw.py .......                                                                                                                  [ 43%]
mne/simulation/tests/test_source.py ......                                                                                                                [ 43%]
mne/stats/_adjacency.py .                                                                                                                                 [ 43%]
mne/stats/cluster_level.py .                                                                                                                              [ 43%]
mne/stats/tests/test_adjacency.py .........                                                                                                               [ 43%]
mne/stats/tests/test_cluster_level.py ...........................................                                                                         [ 45%]
mne/stats/tests/test_multi_comp.py ..                                                                                                                     [ 45%]
mne/stats/tests/test_parametric.py ..........................                                                                                             [ 45%]
mne/stats/tests/test_permutations.py ..                                                                                                                   [ 45%]
mne/stats/tests/test_regression.py ...                                                                                                                    [ 46%]
mne/tests/test_annotations.py ..........................................................                                                                  [ 47%]
mne/tests/test_bem.py ..........                                                                                                                          [ 48%]
mne/tests/test_chpi.py .............                                                                                                                      [ 48%]
mne/tests/test_coreg.py ......                                                                                                                            [ 48%]
mne/tests/test_cov.py ...............................                                                                                                     [ 49%]
mne/tests/test_defaults.py ..                                                                                                                             [ 49%]
mne/tests/test_dipole.py ..s.........                                                                                                                     [ 50%]
mne/tests/test_docstring_parameters.py ...                                                                                                                [ 50%]
mne/tests/test_epochs.py .........................................................................................................................        [ 53%]
mne/tests/test_event.py ............                                                                                                                      [ 54%]
mne/tests/test_evoked.py ....................................                                                                                             [ 55%]
mne/tests/test_filter.py .s.................s.......................................                                                                      [ 57%]
mne/tests/test_import_nesting.py .                                                                                                                        [ 57%]
mne/tests/test_label.py ......................                                                                                                            [ 57%]
mne/tests/test_line_endings.py .                                                                                                                          [ 57%]
mne/tests/test_misc.py .                                                                                                                                  [ 57%]
mne/tests/test_morph.py ................................................................................................................................. [ 61%]
......................................................................................................................................................... [ 66%]
......................................................................................................................................................... [ 71%]
......................................................................................................................................................... [ 75%]
........                                                                                                                                                  [ 76%]
mne/tests/test_morph_map.py .                                                                                                                             [ 76%]
mne/tests/test_ola.py ....                                                                                                                                [ 76%]
mne/tests/test_proj.py ............                                                                                                                       [ 76%]
mne/tests/test_rank.py ...........................................                                                                                        [ 78%]
mne/tests/test_read_vectorview_selection.py .                                                                                                             [ 78%]
mne/tests/test_report.py .......................                                                                                                          [ 78%]
mne/tests/test_source_estimate.py ...........................................................................................                             [ 81%]
mne/tests/test_source_space.py .......s.s...ss..............                                                                                              [ 82%]
mne/tests/test_surface.py .......s....                                                                                                                    [ 82%]
mne/tests/test_transforms.py ....................                                                                                                         [ 83%]
mne/time_frequency/tests/test_ar.py ..                                                                                                                    [ 83%]
mne/time_frequency/tests/test_csd.py ..............                                                                                                       [ 83%]
mne/time_frequency/tests/test_multitaper.py ss                                                                                                            [ 83%]
mne/time_frequency/tests/test_psd.py ......                                                                                                               [ 84%]
mne/time_frequency/tests/test_stft.py ........................................                                                                            [ 85%]
mne/time_frequency/tests/test_stockwell.py .....                                                                                                          [ 85%]
mne/time_frequency/tests/test_tfr.py .............................                                                                                        [ 86%]
mne/utils/_logging.py ..                                                                                                                                  [ 86%]
mne/utils/config.py .                                                                                                                                     [ 86%]
mne/utils/docs.py ...                                                                                                                                     [ 86%]
mne/utils/misc.py .                                                                                                                                       [ 86%]
mne/utils/mixin.py ss                                                                                                                                     [ 86%]
mne/utils/tests/test_bunch.py .                                                                                                                           [ 86%]
mne/utils/tests/test_check.py ...............                                                                                                             [ 87%]
mne/utils/tests/test_config.py ...                                                                                                                        [ 87%]
mne/utils/tests/test_docs.py ........                                                                                                                     [ 87%]
mne/utils/tests/test_fetching.py .                                                                                                                        [ 87%]
mne/utils/tests/test_linalg.py .......................................................................................................................... [ 91%]
......................                                                                                                                                    [ 91%]
mne/utils/tests/test_logging.py ........                                                                                                                  [ 92%]
mne/utils/tests/test_misc.py .                                                                                                                            [ 92%]
mne/utils/tests/test_numerics.py ...........................................................                                                              [ 94%]
mne/utils/tests/test_progressbar.py ....                                                                                                                  [ 94%]
mne/utils/tests/test_testing.py ....                                                                                                                      [ 94%]
mne/viz/_3d.py s                                                                                                                                          [ 94%]
mne/viz/circle.py s                                                                                                                                       [ 94%]
mne/viz/misc.py .                                                                                                                                         [ 94%]
mne/viz/utils.py .                                                                                                                                        [ 94%]
mne/viz/_brain/tests/test_brain.py ..........................s[swscaler @ 0x55f24d712980] Warning: data is not aligned! This can lead to a speed loss
[swscaler @ 0x55cbac150980] Warning: data is not aligned! This can lead to a speed loss
..                                                                                          [ 95%]
mne/viz/_brain/tests/test_notebook.py ...                                                                                                                 [ 95%]
mne/viz/backends/tests/test_renderer.py ..x......                                                                                                         [ 95%]
mne/viz/backends/tests/test_utils.py ..                                                                                                                   [ 95%]
mne/viz/tests/test_3d.py ...............................                                                                                                  [ 96%]
mne/viz/tests/test_3d_mpl.py .....                                                                                                                        [ 96%]
mne/viz/tests/test_circle.py .                                                                                                                            [ 96%]
mne/viz/tests/test_epochs.py .................                                                                                                            [ 97%]
mne/viz/tests/test_evoked.py ...........                                                                                                                  [ 97%]
mne/viz/tests/test_figure.py ..                                                                                                                           [ 97%]
mne/viz/tests/test_ica.py ......                                                                                                                          [ 97%]
mne/viz/tests/test_misc.py .........                                                                                                                      [ 98%]
mne/viz/tests/test_montage.py ......                                                                                                                      [ 98%]
mne/viz/tests/test_raw.py ......................                                                                                                          [ 99%]
mne/viz/tests/test_topo.py ......                                                                                                                         [ 99%]
mne/viz/tests/test_topomap.py ..............                                                                                                              [ 99%]
mne/viz/tests/test_utils.py ...........                                                                                                                   [100%]


==================================================================== slowest 20 test modules ====================================================================
229.39s total  mne/viz/_brain/tests/
168.13s total  mne/preprocessing/tests/
160.47s total  mne/viz/tests/test_3d_mpl.py
159.39s total  mne/minimum_norm/tests/
146.64s total  mne/beamformer/tests/
111.80s total  mne/viz/tests/test_3d.py
 89.24s total  mne/tests/test_morph.py
 84.48s total  mne/inverse_sparse/tests/
 73.05s total  mne/tests/test_epochs.py
 67.16s total  mne/tests/test_rank.py
 61.37s total  mne/tests/test_report.py
 58.92s total  mne/io/fiff/
 46.66s total  mne/tests/test_chpi.py
 46.16s total  mne/viz/tests/test_raw.py
 44.42s total  mne/tests/test_source_estimate.py
 41.12s total  mne/channels/tests/
 35.77s total  mne/forward/tests/
 35.41s total  mne/tests/test_source_space.py
 34.77s total  mne/viz/tests/test_epochs.py
 34.01s total  mne/decoding/tests/


======================================================================= warnings summary ========================================================================
mne/viz/backends/tests/test_renderer.py::test_3d_functions[mayavi]
mne/viz/backends/tests/test_renderer.py::test_3d_functions[mayavi]
  /home/mne_user/miniconda3/lib/python3.8/asyncio/base_events.py:654: ResourceWarning: unclosed event loop <_UnixSelectorEventLoop running=False closed=False debug=False>
    _warn(f"unclosed event loop {self!r}", ResourceWarning, source=self)

-- Docs: https://docs.pytest.org/en/stable/warnings.html
------------------------------------------------ generated xml file: /home/mne_user/mne-python/junit-results.xml ------------------------------------------------
===================================================================== slowest 20 durations ======================================================================
47.84s call     mne/viz/tests/test_3d_mpl.py::test_plot_volume_source_estimates[stat_map-s-1-1-init_p3-want_p3-brain.mgz]
40.51s call     mne/minimum_norm/tests/test_inverse.py::test_inverse_operator_channel_ordering[testing_data-testing_data]
39.31s call     mne/viz/tests/test_3d_mpl.py::test_plot_volume_source_estimates[stat_map-vec-1-1-None-want_p1-None]
27.73s call     mne/viz/tests/test_3d.py::test_plot_alignment[testing_data-testing_data-mayavi]
25.77s call     mne/viz/tests/test_3d_mpl.py::test_plot_volume_source_estimates[glass_brain-s-None-2-None-want_p0-None]
25.57s call     mne/viz/tests/test_3d_mpl.py::test_plot_volume_source_estimates[glass_brain-vec-None-1-init_p2-want_p2-None]
22.34s call     mne/inverse_sparse/tests/test_mxne_inverse.py::test_mxne_inverse_standard[_pytest_param]
21.97s call     mne/viz/tests/test_3d_mpl.py::test_plot_volume_source_estimates_morph
21.93s call     mne/preprocessing/tests/test_fine_cal.py::test_compute_fine_cal
21.87s call     mne/tests/test_report.py::test_render_report[mayavi]
21.06s call     mne/tests/test_report.py::test_render_report[pyvista]
20.46s call     mne/commands/tests/test_commands.py::test_make_scalp_surfaces
19.66s call     mne/viz/_brain/tests/test_brain.py::test_brain_traces[pyvista-mixed-split]
19.20s call     mne/viz/_brain/tests/test_brain.py::test_brain_traces[pyvista-mixed-both]
18.49s call     mne/tests/test_chpi.py::test_calculate_chpi_coil_locs_artemis
18.34s call     mne/tests/test_docstring_parameters.py::test_docstring_parameters
17.22s call     mne/io/eeglab/tests/test_eeglab.py::test_io_set_epochs[fnames1]
16.04s call     mne/viz/_brain/tests/test_notebook.py::test_notebook_interactive[notebook]
15.80s call     mne/tests/test_morph.py::test_volume_source_morph_round_trip[sample-fsaverage-10-12-float-True]
14.95s call     mne/tests/test_morph_map.py::test_make_morph_maps
==================================================================== short test summary info ====================================================================
SKIPPED [1] ../miniconda3/lib/python3.8/site-packages/_pytest/doctest.py:535: unable to import module local('/home/mne_user/mne-python/mne/datasets/_infant/base.py')
SKIPPED [19] ../miniconda3/lib/python3.8/site-packages/_pytest/doctest.py:448: all tests skipped by +SKIP option
SKIPPED [1] mne/commands/tests/test_commands.py:83: Test test_clean_eog_ecg skipped, requires MNE-C.
SKIPPED [1] mne/export/tests/test_export.py:28: eeglabio not installed
SKIPPED [2] mne/export/tests/test_export.py:49: eeglabio not installed
SKIPPED [1] mne/forward/tests/test_forward.py:361: Test test_average_forward_solution skipped, requires MNE-C.
SKIPPED [1] mne/forward/tests/test_make_forward.py:121: Test test_make_forward_solution_kit skipped, requires MNE-C.
SKIPPED [1] mne/forward/tests/test_make_forward.py:250: Test test_make_forward_solution_sphere skipped, requires MNE-C.
SKIPPED [1] mne/io/ctf/tests/test_ctf.py:266: Requires spm dataset
SKIPPED [1] mne/io/ctf/tests/test_ctf.py:322: Requires brainstorm dataset
SKIPPED [1] mne/io/fiff/tests/test_raw_fiff.py:1556: Test test_compensation_raw_mne skipped, requires MNE-C.
SKIPPED [1] mne/io/tests/test_compensator.py:73: Test test_compensation_mne skipped, requires MNE-C.
SKIPPED [1] mne/minimum_norm/tests/test_snr.py:23: Test test_snr skipped, requires MNE-C.
SKIPPED [1] mne/tests/test_dipole.py:99: Test test_dipole_fitting skipped, requires MNE-C.
SKIPPED [1] mne/tests/test_filter.py:30: Test test_mne_c_design skipped, requires MNE-C.
SKIPPED [1] mne/tests/test_filter.py:558: CUDA not enabled
SKIPPED [1] mne/tests/test_source_space.py:257: Test test_discrete_source_space skipped, requires MNE-C.
SKIPPED [1] mne/tests/test_source_space.py:349: Test test_other_volume_source_spaces skipped, requires MNE-C.
SKIPPED [2] mne/tests/test_source_space.py:498: Test test_setup_source_space_spacing skipped, requires MNE-C.
SKIPPED [1] mne/tests/test_surface.py:182: Test test_decimate_surface_sphere skipped, requires Freesurfer (mris_sphere). Got exception ([Errno 2] No such file or directory: 'mris_sphere')
SKIPPED [1] mne/time_frequency/tests/test_multitaper.py:14: Test test_dpss_windows skipped, requires nitime. Got exception (No module named 'nitime')
SKIPPED [1] mne/time_frequency/tests/test_multitaper.py:39: Test test_multitaper_psd skipped, requires nitime. Got exception (No module named 'nitime')
SKIPPED [1] mne/viz/_brain/tests/test_brain.py:395: Save movie only supported on PyVista
XFAIL mne/io/curry/tests/test_curry.py::test_sfreq[both 0]
XFAIL mne/io/curry/tests/test_curry.py::test_sfreq[mismatch]
XFAIL mne/viz/backends/tests/test_renderer.py::test_backend_environment_setup[foo]
XPASS mne/datasets/sleep_physionet/tests/test_physionet.py::test_run_update_age_records 
XPASS mne/datasets/sleep_physionet/tests/test_physionet.py::test_run_update_temazepam_records 
================================= 3222 passed, 43 skipped, 2 deselected, 3 xfailed, 2 xpassed, 2 warnings in 2478.84s (0:41:18) =================================


```

</p>
</details>


## TODO

1) Install freesurfer (maybe only the parts that are called from `mne-python`)
2) Add jupyter lab support preferably as standalone image.
3) Add support for mne versioning
3) Potentially remove python dependencies to reduce image size.
