#!/bin/bash
#SBATCH --job-name=makeCapHist
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/scr/makeCapHist.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/scr/makeCapHist.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/scr

Rscript render_makeCapHist.R

conda deactivate

cp 11_makeCapHist.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp CGA_CH.Rda /home/jdrobins/CGA_BlackBears/scr

scontrol show job ${SLURM_JOB_ID}