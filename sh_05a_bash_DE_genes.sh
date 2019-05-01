method_genes=edgeR

# 1) Quality control of samples

cd ${PBS_O_WORKDIR}

mkdir -p Quality_control_$method_genes/Across_samples/genes

# a) Compare replicates across samples - Correlation matrix

cd ${PBS_O_WORKDIR}/Quality_control_$method_genes/Across_samples/genes

$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix ${PBS_O_WORKDIR}/RSEM.gene.counts.matrix -s ${PBS_O_WORKDIR}/samples.txt --CPM --log2 --min_rowSums 10 --sample_cor_matrix 

# b) Compare replicates across samples - PCA

$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix ${PBS_O_WORKDIR}/RSEM.gene.counts.matrix -s ${PBS_O_WORKDIR}/samples.txt --CPM --log2 --prin_comp 3 --min_rowSums 10 --center_rows

# Note: this will overwrite the file RSEM.gene.counts.matrix.R from the heatmap command. As of now, I don't care for this intermediate file. Regenerate it if necessary.


# 2) Running Differential Expression Analysis

cd ${PBS_O_WORKDIR}

/mnt/ls15/scratch/users/losillam/run_DE_analysis.pl --matrix RSEM.gene.counts.matrix --method $method_genes --samples_file samples.txt --output genes_$method_genes


# 3) Extracting and clustering DE genes
# p-value cutoff for FDR (default: 0.001)
# min abs(log2(a/b)) fold change (default: 2  (meaning 2^(2) or 4-fold)

# go inside the DE output folder
cd genes_$method_genes

$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../RSEM.gene.TMM.EXPR.matrix --samples ../samples.txt
