#!/bin/bash
#SBATCH --job-name=snareLocations
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/sampleinfo/snareLocations.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/sampleinfo/snareLocations.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/sampleinfo

Rscript render_snareLocations.R

cp 1_snareLocations.pdf /home/jdrobins/CGA_BlackBears/PDFs
cp snareLocations.Rda /home/jdrobins/CGA_BlackBears/sampleinfo
cp translatable.csv /home/jdrobins/CGA_BlackBears/sampleinfo
cp -r CGAsnarebuff /home/jdrobins/CGA_BlackBears/sampleinfo

scontrol show job ${SLURM_JOB_ID}
