# paramormyrops_rnaseq
Analysis scripts and code for Paramormyrops RNA-seq project (Citation Forthcoming)

This repository contains files with the code we used in our analysis.

The table below serves as a guide to understand the flow of the code. It details the order in which the code was executed, along with a description and comments of each step.  Notes are shown in **bold** text.

*Note:* that a Singularity file is provided in the folder trinity_singularity to run on high performance computing systems.  This would allow any user capable of running Singularity images to recreate the exact computing environment used for these analyses, though it is not required.


| script/command file   | description      | comments         | additional_outputs (These are provided in  the folder named additional_files) |
|-----------------------|------------------|------------------|-------------------------------------------------------------------------------|
| sh_01_FastQCraw.sh    | assess quality of raw reads|| |
| sh_02_trim_rename_unzip.sh | trim, rename and unzip reads    || |
| sh_03_FastQCtrimmed.sh| assess quality of trimmed reads || |
| **The NCBI transcripts file we used as reference for the align and count steps was from: NCBI Paramormyrops kingsleyae Annotation Release 100, based on genome assembly PKINGS_0.1. We downloaded the transcripts file from here: ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/872/115/GCF_002872115.1_PKINGS_0.1 We used the file called: rna.fna.gz, and removed the sole rRNA transcript present: XR_002837744.1**  ||| |
| cmd_generate_gene_to_trans_file.txt  | generate a gene-to-transcript list from the NCBI transcripts file  | this list is required by the align and count steps       | gene-trans-map.txt|
| sh_04a_RSEMindex.sh   | Index the NCBI transcripts file | calls the singularity container | |
| sh_04a_bash.sh        | Index the NCBI transcripts file | executes commands within the singularity container       | |
| sh_04b_RSEMperIndiv.sh| Aligns reads to NCBI transcripts file and counts reads per gene    | calls the singularity container | |
| sh_04b_bash.sh        | Aligns reads to NCBI transcripts file and counts reads per gene    | executes commands within the singularity container       | |
| sh_04c_matrices.sh    | Build gene expression matrices  | calls the singularity container | |
| sh_04c_bash.sh        | Build gene expression matrices  | executes commands within the singularity container       | |
| **At this point the gene expression matrices (RSEM.gene.counts.matrix and RSEM.gene.TMM.counts.matrix ) use gene names and symbols from the NCBI transcriptome. However, EntrezGeneIDs are preferred for downstream analyses. Therefore, I converted their gene names and symbols to Pkings EntrezGeneIDs with the next R code. The converted files were assigned to the original file names. The original files were first renamed to: \<orginal name>_ORIG_gene_symbols** ||||
| translate_gene_IDs.Rmd| <ol><li> Replace gene names and symbols with EntrezGeneIDs in the gene expression matrices</li> <li> generate a file with the columns Pking EntrezGeneID, gene name, gene symbol and type of gene for each of the predicted 27610 P. kingsleyae genes.</li> <li> This file is named Dic.PkingEntrezGeneID-to-name_symbol_type.txt </li></ol> | This code runs on the renamed files       | Dic.PkingEntrezGeneID-to-name_symbol_type.txt  |
| sh_05a_DE_analyses.sh | <ol> <li> Data exploration - Correlation matrix, PCA </li> <li> DGE and MA plots - all 10 possible pairwise OTU comparisons </li></ol>     | calls the singularity container ||  
| sh_05a_bash_DE_genes.sh    | <ol> <li> Data exploration - Correlation matrix, PCA </li> <li> DGE and MA plots - all 10 possible pairwise OTU comparisons </li>    | executes commands within the singularity container. We modified 2) to use the function estimateDisp() instead of the functions estimateCommonDisp() and estimateTagwiseDisp() | uses the samples.txt file  |  
| Clustering_of_DEG_mean.Rmd | <ol> <li> For each phenotype pair, extract the genes that were on average 4 times more highly expressed in one phenotype than the other (Set B groups) </li> <li> plot expression patterns of the genes in each group from 1) </li></ol>  | generates black & white and colored plots || |
| generate_suppl_files_DEG_comparisons_and_groups.Rmd    | generate the supplemental files with the details of the <ol> <li> 10 DGE comparisons and </li> <li> Set B groups </li>  || |
| sh_06_blastp.sh       | blast P. kingsleyae proteins to D. rerio proteins   | output is split into 7 files, we merged all to one file afterwards | |
| Annotation_wrangling.Rmd   | For each ontology, generate two 'dictionaries':  <ol> <li> Pking Entrez Gene IDs to D. rerio GO IDs </li> <li> D. rerio GO IDs to GO terms  </li> </ol>    | Files from 2) were not used in later scripts, they served as references      | <ol> <li> 1) Dic.PkingEntrezGeneID-to-GO.{ontology}.txt </li><li> Dic.{ontology}.GOid_to_term.txt  </li> |
| enrichment_on_Pkings _all_10_DGE_comparisons.Rmd       |<ol> <li> GO enrichment on all 10 DGE comparisons </li> <li> Horizontal bar plot significant GO terms</li></ol>   | Xcel file from 1) is part of the supplementary files.  This code also produces a file with information on each upregulated gene annotated to enriched GO terms, including how many GO terms the gene was annotated to for a given upregulated list and ontology (frequency). The file served informational purposes     ||
| enrichment_on_Pkings_clusters.Rmd    | <ol> <li> GO enrichment on Set B groups </li> <li> Horizontal bar plot significant GO terms </li></ol>  | Xcel file from 1) is part of the supplementary files.  This code also produces a file with information on each upregulated gene annotated to enriched GO terms, including how many GO terms the gene was annotated to for a given upregulated list and ontology (frequency). The file served informational purposes      ||
| set_C.Rmd   | Intersect upregulated genes and enriched GO terms from Sets A' and B         | The outputs are: <ol> <li> one file per list of upregulated genes </li> <li> one file per list of enriched GO terms </li> <li> Xcel file with upregulated genes (consolidation of output 1) </li> <li> Xcel file with enriched GO terms (consolidation of output 2) </li> <li> Xcel file with information on each upregulated gene annotated to enriched GO terms, including how many GO terms the gene was annotated to for a given upregulated list and ontology (frequency). The file served informational purposes </li> <li> Outputs 3) and 4) are part of the supplemental files </li> |||
