#!/bin/bash
#SBATCH --job-name=fitHooker_bothSexes2
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=120:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/scr/fitHooker_bothSexes2.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/scr/fitHooker_bothSexes2.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_BlackBears/scr

Rscript render_fitHooker_bothSexes2.R

conda deactivate 

cp 23_fitHooker_bothSexes2.pdf /home/jdrobins/CGA_BlackBears/PDFs/
cp Hooker_bothSexes2.Rws /home/jdrobins/CGA_BlackBears/scr/
cp samples-bothSexes2.gzip /home/jdrobins/CGA_BlackBears/scr/

scontrol show job ${SLURM_JOB_ID}