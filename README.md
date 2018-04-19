# vcf_to_dosage.sh
This bash script is used to filter vcf files and convert them to dosage files in a biallelic format

## Prerequisites
This script is developed to be used in CRI at the University of Chicago. If you plan to run it in a different computing system, please install bcf tools and modify it accordingly.   

## Run 
Please include the path to all raw vcf files.  
```
sh bcf_filtering_vcf_to_dosage.sh /group/im-lab/nas40t2/jiamao/Projects/cancer_PredictDB/TCGA/TCGA_BRCA/data/genotype/genotype/impute_filter/ 
```

## Input 
Notice that below is the fake genotype data. 
```
##fileformat=VCFv4.1
##filedate=2017.5.11
##source=Minimac3
##contig=<ID=22>
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=DS,Number=1,Type=Float,Description="Estimated Alternate Allele Dosage : [P(0/1)+2*P(1/1)]">
##FORMAT=<ID=GP,Number=3,Type=Float,Description="Estimated Posterior Probabilities for Genotypes 0/0, 0/1 and 1/1 ">
##INFO=<ID=AF,Number=1,Type=Float,Description="Estimated Alternate Allele Frequency">
##INFO=<ID=MAF,Number=1,Type=Float,Description="Estimated Minor Allele Frequency">
##INFO=<ID=R2,Number=1,Type=Float,Description="Estimated Imputation Accuracy">
##INFO=<ID=ER2,Number=1,Type=Float,Description="Empirical (Leave-One-Out) R-square (available only for genotyped variants)">
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	TCGA-OR-A5MM-9A-01D-A99K-99
2	16976216	22:16976216	G	C	.	PASS	AF=0.92391;MAF=0.07609;R2=0.89988	GT:DS:GP	1|0:1.032:0.003,0.962,0.035
2	16976839	22:16976839	G	C	.	PASS	AF=0.92326;MAF=0.07674;R2=0.95160	GT:DS:GP	1|0:1.008:0.001,0.990,0.009
2	16977135	22:16977135	A	G	.	GENOTYPED_ONLY;PASS	AF=0.07039;MAF=0.07039	GT:DS:GP	0|1:1.000:0.000,1.000,0.000
```

## Output
Notice that below is the fake genotype data. 
```
varID	TCGA-OR-A5MM-9A-01D-A99K-99
2_16976216_G_C_b37	1.032	
2_16976839_G_C_b37	1.008	
2_16977135_A_G_b37	1.000
```

## References
- https://www.biostars.org/p/139362/
- https://samtools.github.io/bcftools/bcftools.html
- https://www.biostars.org/p/270381/
