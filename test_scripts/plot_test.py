import mne
import sys

Brain = mne.viz.get_brain_class()
brain = Brain('fsaverage', 'lh', 'inflated', subjects_dir=mne.datasets.sample.data_path() + '/subjects')
print(brain.plotter)
tmp = brain.plotter.screenshot(sys.argv[1])
print(f'min:{tmp.min()} - max:{tmp.max()}')
