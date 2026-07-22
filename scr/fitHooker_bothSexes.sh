#!/bin/bash
#SBATCH --job-name=fit_both
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=48:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/scr/fitHooker_bothSexes.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/scr/fitHooker_bothSexes.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/scr

Rscript render_fitHooker_bothSexes.R

conda deactivate 

cp 13_fitHooker_bothSexes.pdf /home/jdrobins/CGA_BlackBears/PDFs/
cp Hooker_bothSexes.Rws /home/jdrobins/CGA_BlackBears/scr/
cp samples-bothSexes.gzip /home/jdrobins/CGA_BlackBears/scr/

scontrol show job ${SLURM_JOB_ID}