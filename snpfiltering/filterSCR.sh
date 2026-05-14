#!/bin/bash
#SBATCH --job-name=filterSCR
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/snpfiltering/filterSCR.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/snpfiltering/filterSCR.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/snpfiltering

Rscript render_filterSCR.R

cp 3_filterSCR.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp LGC_SCR.vcf /home/jdrobins/CGA_BlackBears/snpfiltering
cp sampleMetadata_nSNPgt.csv /home/jdrobins/CGA_BlackBears/sampleinfo
cp sampleMetadata_nSNPgt.csv /scratch/jdrobins/CGA_BlackBears/sampleinfo

scontrol show job ${SLURM_JOB_ID}