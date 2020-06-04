#!/bin/bash
#SBATCH --time=30:00:00
#SBATCH --account=def-amichaud
#SBATCH --mail-user=sylvain.iceta.1@ulaval.ca
#SBATCH --mail-type=ALL
cd
module load singularity freesurfer fsl 
singularity run --cleanenv -B /home/icetasy/projects/def-amichaud/icetasy/gutbrain/:/data /data/fmriprep.simg /data/BIDS /data/Preproc --fs-license-file /data/freesurfer.txt --skip_bids_validation participant