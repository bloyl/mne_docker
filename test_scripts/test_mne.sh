#!/bin/bash

INSTALL_LOCATION="/home/jovyan/work"
cd $INSTALL_LOCATION
git clone https://github.com/mne-tools/mne-python.git


cd $INSTALL_LOCATION/mne-python
# pip uninstall -y mne
# pip install -e .

# install testing / doc requirements
pip install -r requirements_testing.txt
# pip install -r requirements_doc.txt
# conda install graphviz
# sudo apt install optipng

# grab testing data.
python -c "import mne; mne.datasets.testing.data_path(verbose=True);"

# run tests
make test
