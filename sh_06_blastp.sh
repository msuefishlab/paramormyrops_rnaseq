#!/bin/sh -login
#PBS -j oe
#PBS -l nodes=1:ppn=2,walltime=06:00:00,mem=1gb,feature=lac
#PBS -M losillam@msu.edu
#PBS -m abe
#PBS -N blastp.NCBI
#PBS -r n
#PBS -t 0-6

module load GNU/4.9
module load BLAST+/2.6

cd ${PBS_O_WORKDIR}

blastp -db Zebrafish_ref_NCBI/Danio_rerio.GRCz11.proteins.faa -query Pkings_NCBI_proteome/split_fastas/Pkings.proteins_${PBS_ARRAYID}.fasta -evalue 1e-10 -outfmt 6 -num_alignments 1 -soft_masking true -lcase_masking -max_hsps 1 -out split_blast_results/Pkings.proteins_${PBS_ARRAYID}.NCBI.blastp

# writes out a report that you can refer to on walltime/memory usage etc.
check ${PBS_JOBID}
qstat -f ${PBS_JOBID}
