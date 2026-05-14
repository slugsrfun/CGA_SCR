#!/bin/bash
#SBATCH --job-name=recapFinal
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/recaps/recapFinal.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/recaps/recapFinal.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/recaps

Rscript render_recapFinal.R

conda deactivate 

cp 10_recapFinal.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp ../sampleinfo/sampleMetaData_cloneID.csv /home/jdrobins/CGA_BlackBears/sampleinfo/

scontrol show job ${SLURM_JOB_ID}