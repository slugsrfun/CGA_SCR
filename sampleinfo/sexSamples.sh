#!/bin/bash
#SBATCH --job-name=sexSamples
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/sampleinfo/sexSamples.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/sampleinfo/sexSamples.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/sampleinfo

Rscript render_sexSamples.R

conda deactivate

cp 9_sexSamples.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp sampleMetadata_sexGT.csv /home/jdrobins/CGA_BlackBears/sampleinfo

scontrol show job ${SLURM_JOB_ID}