#!/bin/bash
#SBATCH --job-name=recapPLINK
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/recaps/recapPLINK.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/recaps/recapPLINK.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/recaps

Rscript render_recapPLINK.R

conda deactivate 

cp 5_recapPLINK.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp recapPLINK.kin0 /home/jdrobins/CGA_BlackBears/recaps

scontrol show job ${SLURM_JOB_ID}