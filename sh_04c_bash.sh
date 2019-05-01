#!/bin/bash -login


cd ${PBS_O_WORKDIR}/Align_and_Counts


indiv=(P*/)


#Build Transcript and Gene Expression Matrices   https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Transcript-Quantification#rsem-output
#Using the transcript and gene-level abundance estimates for each of your samples, construct a matrix of counts and a matrix of normalized expression values using the following script
$TRINITY_HOME/util/abundance_estimates_to_matrix.pl --est_method RSEM --gene_trans_map ${PBS_O_WORKDIR}/gene-trans-map.txt --name_sample_by_basedir --out_prefix RSEM ${indiv[0]}RSEM.isoforms.results ${indiv[1]}RSEM.isoforms.results ${indiv[2]}RSEM.isoforms.results ${indiv[3]}RSEM.isoforms.results ${indiv[4]}RSEM.isoforms.results ${indiv[5]}RSEM.isoforms.results ${indiv[6]}RSEM.isoforms.results ${indiv[7]}RSEM.isoforms.results ${indiv[8]}RSEM.isoforms.results ${indiv[9]}RSEM.isoforms.results ${indiv[10]}RSEM.isoforms.results

#Notice this important info from the Trinity website (we will be using gene counts only): 
#When you include the --gene_trans_map file above, it will automatically generate the gene-level count and expression matrices, using the 'scaledTPM' method as described in txImport but implemented here directly in the Trinity script. This 'scaledTPM' method for estimating gene counts accounts for differences in isoform lengths that could otherwise lead to false gene DE reporting under situations where it is differential transcript usage (DTU) as opposed to differential gene expression (DGE) occurring. See Soneson et al., F1000 Research, 2016 for details.
