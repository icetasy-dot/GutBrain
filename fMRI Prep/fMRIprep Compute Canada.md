# Preprocessing your scans with fMRIprep and Compute Canada

<p align="center">
<img src="/Illustration/fmri%20prep.png" width="30%" height="30%"> <img src="/Illustration/ComputeCanada_logo_0.gif" width="40%" height="40%">
</p>


#### Reference website [here](https://fmriprep.readthedocs.io/en/stable/index.html).

#### Reference article : Esteban, O., Markiewicz, C.J., Blair, R.W. et al. fMRIPrep: a robust preprocessing pipeline for functional MRI. Nat Methods 16, 111–116 (2019). [https://10.1038/s41592-018-0235-4](https://www.nature.com/articles/s41592-018-0235-4)

## How to connect to Compute Canada (CC)

### Read and learn first !

The wiki is very full of usefull tips : [Compute Canada Wiki](https://docs.computecanada.ca/wiki/Compute_Canada_Documentation).

You can (and should) also watch the Brain Hack School 2020 lecture : [High Performance Computing](https://www.youtube.com/embed/J9VCHe1ovBg).

<p align="center">
<a href="https://youtu.be/J9VCHe1ovBg"><img src="https://img.youtube.com/vi/J9VCHe1ovBg/0.jpg" width="50%"></a>
</p>

### Log into compute canada (CC)

Run the command line (we use Beluga by default in the team but you can choose any other one you want)

Command line : 
`ssh username@beluga.computecanada.ca`

Example : 
My username is `icetasy` , so the commande line for me is : `ssh icetasy@beluga.computecanada.ca`

You'll need your password then! 



## Prepapre your dataset


### Ask you PI for the directory and the procedure to access lab data on CC

Normaly MRI data will be soon available in BIDS format on CC (thanks to the Brain Hack School)

### If you want to upload your own data :

Make shure to have prepare your destination folder on CC (at projects space if possible) , using `mkdir` to create your folder may be easier! 

Example for me : 

`mkdir /home/icetasy/projects/def-amichaud/icetasy/gutbrain`

#### Transfer your data using `scp` 

Don't forget to exit compute canada server and work on your local terminal using scp (secure copy) : 

Command line : 
`scp -r [/local/path/] [user@host]:[/remote/path]`

`-r` is for recurcise cand be omit when just one file 

In ny case : 

`scp -r /Users/sylvainiceta/Documents/NouveauxScan/BIDS icetasy@beluga.computecanada.ca:/home/icetasy/projects/def-amichaud/icetasy/gutbrain`


## Install fMRIprep using singularity (recommanded)

If you want to run fMRIprep using python please go [here](#fmri_python).
<br>
<br>
<img align="left" src="/Illustration/warning.jpg" width="10%" height="10%"> Don'forget to record your package version using and keep preciously this file! </p>
<br>
<br>
Command line :
`pip freeze > requirements.txt`

And then recovering the version will be as easy as : `pip install -r requirements.txt`

### You need docker on your computer

Please find all informations needed on [Docker web site](https://docs.docker.com/get-docker/).

You can (and should) also watch the Brain Hack School 2020 lecture to learn more about docker : [A journey through virtualization](https://www.youtube.com/embed/7BJqzpE76g0). 
<p align="center"><iframe width="640" height="360" src="https://www.youtube.com/embed/7BJqzpE76g0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></p>


### Refer to fMRI prep [website](https://fmriprep.readthedocs.io/en/stable/installation.html) for singularity installation

<br>
<img img align="left" src="/Illustration/singularity.jpg" width="35%" height="35%"> 
<br>
<br>
“Man is something that shall be overcome. Man is a rope, tied between beast and overman — a rope over an abyss. What is great in man is that he is a bridge and not an end.”
<br>
<br>
<p align="right"> <b>Friedrich Wilhelm Nietzsche, Thus Spoke Zarathustra</b> </p> 
<br>
<br>
### Step 1 _ Don't forget to load singularity on your directory 

`module load singularity`

In the same time you can load fMRIprep dependancies :

`module load freesurfer fsl`

### Step 2 _ Preparing a Singularity image 


#### Solution 1 :Make the singularity image on directly on CC. 

*To verify :* For making it directly on CC, you have to use a SBATCH file. CC do not allow you to creat the image from your terminal.

Command line :
`singularity build /my_images/fmriprep-<version>.simg docker://poldracklab/fmriprep:<version>`

In our example : 

`singularity build /my_images/fmriprep-20.1.0.simg docker://poldracklab/fmriprep:20.1.0`

SBATCH file example : [singularity.sh](to create)

	#!/bin/bash
	#SBATCH --time=03:00:00
	#SBATCH --account=def-someuser
	#SBATCH --mail-user=<email_address>
	#SBATCH --mail-type=BEGIN
	#SBATCH --mail-type=END
	#SBATCH --mail-type=FAIL
	#SBATCH --mail-type=REQUEUE
	#SBATCH --mail-type=ALL
	singularity build /my_images/fmriprep-20.1.0.simg docker://poldracklab/fmriprep:20.1.0


Then you'll have to upload your .sh file on CC :
`sbatch singularity.sh` 

For more information on SBATCH file : [Wiki Compute Canada](https://docs.computecanada.ca/wiki/Running_jobs/fr).

#### Solution 2 :Make the singularity image on your computer and copy it on CC.
Create the singulqrity image using docker :
	`docker run --privileged -t --rm -v /var/run/docker.sock:/var/run/
	docker.sock -v /Users/sylvainiceta/singularity_fmriprep\image:/output
	singularityware/docker2singularity poldracklab/fmriprep:latest`

Then, transfer on CC your singularity image `*.simg`: 
`scp /Users/sylvainiceta/singularity_fmriprepimage/poldracklab_fmriprep_<version>.simg icetasy@beluga.computecanada.ca:/home/icetasy/projects/def-amichaud/icetasy/gutbrain/fmriprep.simg`

`<version>` is the ended part of the file name.

For example : 
`scp /Users/sylvainiceta/singularity_fmriprepimage/poldracklab_fmriprep_latest-2020-05-28-e4d9c75a94b2.simg icetasy@beluga.computecanada.ca:/home/icetasy/projects/def-amichaud/icetasy/gutbrain/fmriprep.simg`



## Launch fMRI prep with singularity 

### Never so easy : Don't forget to upload your freesurfer licence !

#### You have first to register on [free surfer website](https://surfer.nmr.mgh.harvard.edu/registration.html) and you'll receive your licence by email.

#### Then you have to upload your licence file on compute canada :

Commande line :
`scp /Users/<LOCAL PATH>/freesurfer_licence.txt username@beluga.computecanada.ca:/home/< CC PATH>`

In our example :
`scp /Users/sylvainiceta/Documents/NouveauxScan/BIDS/freesurfer.txt icetasy@beluga.computecanada.ca:/home/icetasy/projects/def-amichaud/icetasy/gutbrain`

### Now you can launch fMRIprep

<img align="left" src="/Illustration/warning.jpg" width="10%" height="10%"> But using a SBATCH file! 
<br>
<br>
<br>
<img align="left" src="/Illustration/warning.jpg" width="10%" height="10%">
 Don't only Copy Paste, bellow syntax is only an generic one, you have to think about the argument to use !!! More information [here](https://fmriprep.readthedocs.io/en/stable/usage.html).

	#!/bin/bash
	#SBATCH --time=30:00:00
	#SBATCH --account=def-someuser
	#SBATCH --mail-user=<email_address>
	#SBATCH --mail-type=BEGIN
	#SBATCH --mail-type=END
	#SBATCH --mail-type=FAIL
	#SBATCH --mail-type=REQUEUE
	#SBATCH --mail-type=ALL
	singularity run --cleanenv fmriprep.simg /<PATH BIDS DATA>/BIDS /<PATH OUTPUT DATA>/Preproc participant --fs-license-file /<PATH TO LICENCE>/freesurfer_licence.txt --skip_bids_validation

In our example this could be : 

	#!/bin/bash
	#SBATCH --time=30:00:00
	#SBATCH --account=def-amichaud
	#SBATCH --mail-user=sylvain.iceta.1@ulaval.ca
	#SBATCH --mail-type=BEGIN
	#SBATCH --mail-type=END
	#SBATCH --mail-type=FAIL
	#SBATCH --mail-type=REQUEUE
	#SBATCH --mail-type=ALL
	singularity run --cleanenv fmriprep.simg /home/icetasy/projects/def-amichaud/icetasy/gutbrain/BIDS /home/icetasy/projects/def-amichaud/icetasy/gutbrain/Preproc participant --fs-license-file /home/icetasy/projects/def-amichaud/icetasy/gutbrain/freesurfer.txt --skip_bids_validation
	

IMAGE RUNNING


## <a name="fmri_python"></a>Install fMRIprep using Python

### Step 1 _ Log into compute canada (CC)

Run the command line (we use Beluga by default in the team but you can choose any other one you want)

`ssh username@beluga.computecanada.ca`

My username : icetasy , so the commande line for me is : `ssh icetasy@beluga.computecanada.ca`


### Step 2 _ Create and enter in your virtual environnement

fMRI prep is a python librairy not an software. It'is not available trhough `module load` commande.

For mnore infromation : [Wiki Python](https://docs.computecanada.ca/wiki/Python)

All python available python package or librairy are listed [here](https://docs.computecanada.ca/wiki/Available_Python_wheels).

#### We have to create an virtual environnement for run fMRI prep

`cd`

`module add python/3.7`

`virtualenv ~/MRI` or anyother name you want / can also use `virtualenv --no-download ~/ENV`

`source ~/MRI/bin/activate` can also be localized elserwer regarding in wich directory you made previous command line.

May need to uprgrade pip : `pip install --no-index --upgrade pip`

`--no-index` avoid downloading version outside CC.

N.B. : To deactivate virtual environnement : 
`deactivate `

### Step 3 _ Install fMRI prep (we're running the python version not the docker or singularity one)

Please check first i's not already install. you can also check for all currently available wheels on the [Wiki Python Wheels](https://docs.computecanada.ca/wiki/Available_Python_wheels) or using the command line `avail_wheels`

Before installing fMRI prep,load needed module :
`module load freesurfer`
`module load fsl`

Install fMRI prep :

`pip install fmriprep`

Numerous bugs or missing package mays occurs, be patient and use google (sorry we decided not to use docker for right now _ working on_)

### Step 4 _ Now you can launch fMRIprep *# Not check yet*

IMAGE WARNING But using a SBATCH file! 

IMAGE WARNING Don't only Copy Paste, bellow syntax is only an generic one, you have to think about the argument to use !!! More information [here](https://fmriprep.readthedocs.io/en/stable/usage.html).

	#!/bin/bash
	#SBATCH --time=30:00:00
	#SBATCH --account=def-someuser
	#SBATCH --mail-user=<email_address>
	#SBATCH --mail-type=BEGIN
	#SBATCH --mail-type=END
	#SBATCH --mail-type=FAIL
	#SBATCH --mail-type=REQUEUE
	#SBATCH --mail-type=ALL
	source ~/MRI/bin/activate
	fmriprep /<PATH BIDS DATA>/BIDS /<PATH OUTPUT DATA>/Preproc participant --fs-license-file /<PATH TO LICENCE>/freesurfer_licence.txt --skip_bids_validation

In our example this could be : 

	#!/bin/bash
	#SBATCH --time=30:00:00
	#SBATCH --account=def-amichaud
	#SBATCH --mail-user=<sylvain.iceta.1@ulaval.ca>
	#SBATCH --mail-type=BEGIN
	#SBATCH --mail-type=END
	#SBATCH --mail-type=FAIL
	#SBATCH --mail-type=REQUEUE
	#SBATCH --mail-type=ALL
	source ~/MRI/bin/activate
	fmriprep /home/icetasy/projects/def-amichaud/icetasy/gutbrain/BIDS /home/icetasy/projects/def-amichaud/icetasy/gutbrain/Preproc participant --fs-license-file /home/icetasy/projects/def-amichaud/icetasy/gutbrain/freesurfer.txt --skip_bids_validation
	

IMAGE RUNNING


`fmriprep /home/icetasy/projects/def-amichaud/icetasy/gutbrain/BIDS /home/icetasy/projects/def-amichaud/icetasy/gutbrain/Preproc participant`

06 -01-2020
missing : pip install sentry_sdk bids_validator

+
