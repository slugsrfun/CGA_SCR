#!/bin/bash
#SBATCH --job-name=runCOLONY
#SBATCH --partition=batch
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem=64gb
#SBATCH --time=48:00:00
#SBATCH --output=/scratch/jdrobins/CGA_BlackBears/recaps/runCOLONY.o
#SBATCH --error=/scratch/jdrobins/CGA_BlackBears/recaps/runCOLONY.o

cd /scratch/jdrobins/
cp -r /home/jdrobins/colony2_Lnx_25_02_2024 ./
cd colony2_Lnx_25_02_2024
cp /scratch/jdrobins/CGA_BlackBears/recaps/CGA_COLONY.dat ./ 

ml impi/2021.6.0-intel-compilers-2022.1.0

srun -n 8 ./colony2p.ifort.impi2018.out IFN:CGA_COLONY.dat

cp CGA.* /home/jdrobins/CGA_BlackBears/recaps/
cp CGA.* /scratch/jdrobins/CGA_BlackBears/recaps/

scontrol show job ${SLURM_JOB_ID}