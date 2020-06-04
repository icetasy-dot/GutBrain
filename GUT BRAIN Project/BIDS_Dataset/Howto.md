# FROM RAW DATA to READY FILE FOR PREPROCESSING

## "Bidsification" of fMRI data

### Aim 1: Convert DICOM to NIFIT 

3 possibilities :
https://heudiconv.readthedocs.io/en/latest/
https://github.com/NILAB-UvA/bidsify
https://github.com/rordenlab/dcm2niix/

Try 1 : BidSify

This package offers a tool to convert your raw (f)MRI data to the "Brain Imaging Data Structuce" (BIDS) format. 

Based on dcm2niix and the following Python packages:
nibabel
scipy
numpy
joblib (for parallelization)
pandas


### Aim 2 : Bids Validation

Install Bids - validator 

npm install -g bids-validator

### Aim 3 : Dataset exploration

PyBIDS


