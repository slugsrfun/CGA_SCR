#!/bin/bash
#SBATCH --job-name=compileMeta
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=2:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/sampleinfo/compileMetadata.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/sampleinfo/compileMetadata.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/sampleinfo

Rscript render_compileMetadata.R

cp 2_compileMetadata.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp sampleMetadata_basic.csv /home/jdrobins/CGA_BlackBears/sampleinfo

scontrol show job ${SLURM_JOB_ID}
