#!/bin/sh -login
#PBS -j oe
#PBS -l nodes=1:ppn=1,walltime=03:59:00,mem=3gb,feature=lac
#PBS -M losillam@msu.edu
#PBS -m abe
#PBS -N DE-analysis
#PBS -r n

# -o : tells it where to put output from your job
# -j oe : specifies that output and error messages from your job can be placed in the same location
# -l : resource requests (maximum amounts needed for each)
# -M : email address to send status updates to
# -m abe : what to send email updates about (abort, begin, end)
# -N : names your job
# -r n : tells it not to re-run the script in the case of an error (so it doesn't overwrite any results generated by your job)
# -t use the array flag to submit multiple jobs

# clear modules
 
module purge
module load singularity


cd ${PBS_O_WORKDIR}

singularity exec /mnt/ls15/scratch/users/losillam/trinity.img ./sh_05a_bash_DE_genes.sh

# writes out a report that you can refer to on walltime/memory usage etc.
check $PBS_JOBID
qstat -f ${PBS_JOBID}


