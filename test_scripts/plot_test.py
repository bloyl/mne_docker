import mne

Brain = mne.viz.get_brain_class()

brain = Brain('fsaverage', 'lh', 'inflated', subjects_dir=mne.datasets.sample.data_path() + '/subjects')
tmp = brain.plotter.screenshot('/outputs/brain_plot.png')
# tmp = brain.plotter.screenshot('./brain_plot.png')
print(f'min:{tmp.min()} - max:{tmp.max()}')
