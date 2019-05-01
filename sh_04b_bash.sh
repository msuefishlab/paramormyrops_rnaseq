#!/bin/bash -login

cd ${PBS_O_WORKDIR}

mkdir ${PBS_O_WORKDIR}/Align_and_Counts

cd ${PBS_O_WORKDIR}/../ReadsTrimmed/

files=(tr_468*1P.fastq)
F1=${files[${PBS_ARRAYID}]}

F2=tr_469${F1#tr_468}
F3=tr_470${F1#tr_468}
R1=${F1%1P.fastq}2P.fastq
R2=tr_469${R1#tr_468}
R3=tr_470${R1#tr_468}

dummy=${F1%_??????_1P.fastq}
indiv=${dummy##*_N_}

echo $indiv >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo -en '\n' >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt

echo $F1 >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo $F2 >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo $F3 >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo -en '\n' >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt

echo $R1 >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo $R2 >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo $R3 >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo -en '\n' >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt
echo -en '\n' >> ${PBS_O_WORKDIR}/Align_and_Counts/List_of_input_reads_RSEM.txt

mkdir ${PBS_O_WORKDIR}/Align_and_Counts/${indiv}


$TRINITY_HOME/util/align_and_estimate_abundance.pl --thread_count 4 --transcripts ${PBS_O_WORKDIR}/NCBI_reference/NCBI_Pkings_0.1_RNA_no_rRNA.fna --gene_trans_map ${PBS_O_WORKDIR}/gene-trans-map.txt --seqType fq --left $F1,$F2,$F3 --right $R1,$R2,$R3 --est_method RSEM --aln_method bowtie2 --output_dir ${PBS_O_WORKDIR}/Align_and_Counts/${indiv}

