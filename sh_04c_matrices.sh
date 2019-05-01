#!/bin/sh -login
#PBS -j oe
#PBS -l nodes=1:ppn=1,walltime=00:30:00,mem=8gb,feature=lac
#PBS -M losillam@msu.edu
#PBS -m abe
#PBS -N abundancesExN50
#PBS -r n

cd ${PBS_O_WORKDIR}

module purge
module load singularity


singularity exec /mnt/ls15/scratch/users/losillam/trinity.img ./sh_04c_bash.sh


check $PBS_JOBID
qstat -f $PBS_JOBID
