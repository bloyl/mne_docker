import mne
import sys

Brain = mne.viz.get_brain_class()
brain = Brain('fsaverage', 'lh', 'inflated', subjects_dir=mne.datasets.sample.data_path() + '/subjects')
print(brain.plotter)
if len(sys.argv) >=2:
    tmp = brain.plotter.screenshot(sys.argv[1])
else:
    tmp = brain.plotter.screenshot()
print(f'min:{tmp.min()} - max:{tmp.max()}')
