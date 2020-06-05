<h1 align="center"> FROM RAW DATA to READY FILE FOR PREPROCESSING </h1>

<h2 align="center"> "Bidsification" of our data <br> </h2>

<br>
## STEP 1: Convert DICOM to BIDS 

During the Brain Hack school we tried : [HeuDiConv](https://heudiconv.readthedocs.io/en/latest/), [bidsify](https://github.com/NILAB-UvA/bidsify) and [Dcm2Bids](https://github.com/cbedetti/Dcm2Bids).

After multiple trying, the last one retain our attention !

See the [TUTORIAL](https://cbedetti.github.io/Dcm2Bids/tutorial/).

1. How to install :

`pip install dcm2bids`

2. How to run :

`mkdir <YOUR_FUTURE_BIDS_FOLDER>`
`cd <YOUR_FUTURE_BIDS_FOLDER>`
`dcm2bids_scaffold`
`dcm2bids_helper -d <FOLDER_WITH_DICOMS_OF_A_TYPICAL_SESSION>`
Build your configuration file with the help of the content of tmp_dcm2bids/helper
`dcm2bids -d DICOM_DIR -p PARTICIPANT_ID -c CONFIG_FILE` for each participants of your study

3. Progress :

<p align="center"><img align='center' src="https://github.com/icetasy-dot/GutBrain/blob/master/Illustration/processing.gif" width="45%" height="45%"></p>

## Step 2 : Bids Validation

You can do it [Online](https://bids-standard.github.io/bids-validator/).

Or you can install Bids - validator :

1. **Docker**

Install Docker

From a terminal run :
`docker run -ti --rm -v /path/to/data:/data:ro bids/validator /data` but replace the /path/to/data part of the command with your own path on your machine.

2. **Python Library**

Install Python (works with python2 and python3)

Install Pip package manager for python, if not already installed.

From a terminal run :
`pip install bids_validator` 

Open a Python terminal `python`

Import the BIDS Validator package `from bids_validator import BIDSValidator` can be used in Jupyter Notebook.

Check if a file is BIDS compatible :
 `BIDSValidator().is_bids('path/to/a/bids/file')`

npm install -g bids-validator

## Step 3 : Dataset exploration

We choosed to use **PyBIDS**.

GitHub Repositories : [here](https://github.com/bids-standard/pybids)

PyBIDS is most easily installed from pip. To install the latest official release:

`pip install pybids`

If you want to live on the bleeding edge, you can install from master:

[pip install git+https://github.com/bids-standard/pybids.git]()

Dependencies
PyBIDS has a number of dependencies. The core querying functionality requires only the BIDS-Validator package. However, most other modules require the core Python neuroimaging stack: numpy, scipy, pandas, nibabel, and patsy. The reports module additionally requires num2words. By default, all dependencies will be installed with pybids (if they aren't already available).


<p align="center">
<a href="Readme.md"><img src="https://github.com/icetasy-dot/GutBrain/blob/master/Illustration/back.png" width="30%"></a>
</p>
