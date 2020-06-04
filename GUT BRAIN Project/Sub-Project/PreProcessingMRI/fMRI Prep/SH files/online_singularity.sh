#!/bin/bash
#SBATCH --time=30:00:00
#SBATCH --account=def-amichaud
#SBATCH --mail-user=sylvain.iceta.1@ulaval.ca
#SBATCH --mail-type=ALL
module load singularity
singularity build /my_images/fmriprep-20.1.0.simg docker://poldracklab/fmriprep:20.1.0


