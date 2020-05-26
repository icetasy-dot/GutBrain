# Using HeuDiConv

Aim : convert DICOM to BIDS

Resources : [http://reproducibility.stanford.edu/bids-tutorial-series-part-2a/
](http://reproducibility.stanford.edu/bids-tutorial-series-part-2a/)

####Step 1 _ Installation : 

`docker pull nipy/heudiconv:latest`

#### Step 2 _ Run HeuDiConv :


> docker run --rm -it -v /Users/sylvainiceta/Documents/NouveauxScan:/base nipy/heudiconv:latest -d /base/Dicom/*.dcm -o /base/Nifti/ -f convertall -c none --overwrite`