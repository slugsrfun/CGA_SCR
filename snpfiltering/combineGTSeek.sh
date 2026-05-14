#!/bin/bash
#SBATCH --job-name=combineGTSeek
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/snpfiltering/combineGTSeek.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/snpfiltering/combineGTSeek.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/snpfiltering

Rscript render_combineGTSeek.R

conda deactivate

cp 4_combineGTSeek.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp finalSCR.recode.vcf /home/jdrobins/CGA_BlackBears/snpfiltering
cp sampleMetadata_combined.csv /home/jdrobins/CGA_BlackBears/sampleinfo
cp sampleMetadata_combined.csv /scratch/jdrobins/CGA_BlackBears/sampleinfo

scontrol show job ${SLURM_JOB_ID}