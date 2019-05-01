#!/bin/sh -login
#PBS -j oe
#PBS -l nodes=1:ppn=1,walltime=00:40:00,mem=4gb,feature=lac
#PBS -M losillam@msu.edu
#PBS -m abe
#PBS -N RSEMindex
#PBS -r n

cd ${PBS_O_WORKDIR}

# clear modules
 
module purge
module load singularity

 
singularity exec /mnt/ls15/scratch/users/losillam/trinity.img ./sh_04a_bash.sh

check $PBS_JOBID
qstat -f $PBS_JOBID
