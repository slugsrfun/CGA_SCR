#!/bin/bash
#SBATCH --job-name=assessPVA
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=72:00:00
#SBATCH --output=/scratch/jdrobins/CGA_SCR/other/assessPVA.o
#SBATCH --error=/scratch/jdrobins/CGA_SCR/other/assessPVA.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_SCR/other

Rscript render_assessPVA.R

conda deactivate

cp 14_assessPVA.pdf /home/jdrobins/CGA_SCR/PDFs/
cp jc4.gzip /home/jdrobins/CGA_SCR/other
cp forc* /home/jdrobins/CGA_SCR/other

scontrol show job ${SLURM_JOB_ID}