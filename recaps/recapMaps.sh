#!/bin/bash
#SBATCH --job-name=recapMaps
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=1:00:00
#SBATCH --output=/scratch/jdrobins/CGA_SCR/recaps/recapMaps.o
#SBATCH --error=/scratch/jdrobins/CGA_SCR/recaps/recapMaps.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_SCR/recaps

Rscript render_recapMaps.R

conda deactivate 

cp 12_recapMaps.pdf /home/jdrobins/CGA_SCR/PDFs

scontrol show job ${SLURM_JOB_ID}