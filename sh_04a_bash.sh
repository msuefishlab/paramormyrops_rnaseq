#!/bin/bash -login

cd ${PBS_O_WORKDIR}

$TRINITY_HOME/util/align_and_estimate_abundance.pl --thread_count 1 --transcripts ${PBS_O_WORKDIR}//NCBI_reference/NCBI_Pkings_0.1_RNA_no_rRNA.fna --gene_trans_map gene-trans-map.txt --seqType fq --est_method RSEM --aln_method bowtie2 --prep_reference --output_dir ${PBS_O_WORKDIR}//NCBI_reference
