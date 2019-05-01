#!/bin/sh -login
#PBS -j oe
#PBS -l nodes=1:ppn=5,walltime=4:00:00,mem=16gb,feature=lac
#PBS -M losillam@msu.edu
#PBS -m abe
#PBS -N RSEM
#PBS -r n
#PBS -t 0-10

cd ${PBS_O_WORKDIR}

# clear modules
 
module purge
module load singularity

 
SINGULARITYENV_PBS_ARRAYID=${PBS_ARRAYID} singularity exec /mnt/ls15/scratch/users/losillam/trinity.img ./sh_04b_bash.sh


check $PBS_JOBID
qstat -f $PBS_JOBID
