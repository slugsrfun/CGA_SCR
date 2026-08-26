#!/bin/bash
#SBATCH --job-name=fit_both
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=60:00:00
#SBATCH --output=/scratch/jdrobins/CGA_SCR/scr/fitHooker_bothSexes.o
#SBATCH --error=/scratch/jdrobins/CGA_SCR/scr/fitHooker_bothSexes.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_SCR/scr

Rscript render_fitHooker_bothSexes.R

conda deactivate 

cp 13_fitHooker_bothSexes.pdf /home/jdrobins/CGA_SCR/PDFs/
cp samples-bothSexes_v1.gzip /home/jdrobins/CGA_SCR/scr/
cp samples-bothSexes_v2.gzip /home/jdrobins/CGA_SCR/scr/
cp waic-bothSexes_v1.gzip /home/jdrobins/CGA_SCR/scr/
cp waic-bothSexes_v2.gzip /home/jdrobins/CGA_SCR/scr/

scontrol show job ${SLURM_JOB_ID}