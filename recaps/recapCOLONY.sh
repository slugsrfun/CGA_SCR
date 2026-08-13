#!/bin/bash
#SBATCH --job-name=recapCOLONY
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=1:00:00
#SBATCH --output=/scratch/jdrobins/CGA_SCR/recaps/recapCOLONY.o
#SBATCH --error=/scratch/jdrobins/CGA_SCR/recaps/recapCOLONY.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_SCR/recaps

Rscript render_recapCOLONY.R

conda deactivate

cp 8_recapCOLONY.pdf /home/jdrobins/CGA_SCR/PDFs

scontrol show job ${SLURM_JOB_ID}