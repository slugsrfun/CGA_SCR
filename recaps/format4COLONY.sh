#!/bin/bash
#SBATCH --job-name=format4COLONY
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/recaps/format4COLONY.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/recaps/format4COLONY.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/recaps

Rscript render_format4COLONY.R

conda deactivate

cp 6_format4COLONY.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp CGA_COLONY.dat /home/jdrobins/CGA_BlackBears/recaps

scontrol show job ${SLURM_JOB_ID}
