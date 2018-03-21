#!/bin/bash
#PBS -N job_gtex_v8
#PBS -S /bin/bash
#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
########################################################################################################################
#CRI submission dandruff
#cd $PBS_O_WORKDIR
#module load gcc/6.2.0
#module load zlib/1.2.8
#module load bzip2/1.0.6
#module load xz/5.2.2
#module load htslib/1.4.0
module load gcc/4.9.4
module load bcftools/1.4.0
########################################################################################################################

for file in $1*; do

	I=$file
	OUTPUT=${file/%??????}biallelic.txt.gz 

	NOW=$(date +%Y-%m-%d/%H:%M:%S)
	echo "Starting at $NOW"
	echo $file
	echo $OUTPUT

	# create column names such as "varID	TCGA-OR-A5LA-10A-01&-A99K-99	TCGA-OR-A5LK-10&-01D-A99K-99 . . . "
	echo -ne "varID\t" | gzip - | cat - > $OUTPUT
	bcftools query -l $I | tr '\n' '\t' | sed 's/\t$/\n/' - | gzip - |  cat - >> $OUTPUT

	# Filter files like those in GTEx to specific individuals, keeping only biallelic snps with MAF<0.01 (MAF already filtered in the original file, if not, please include MAF<0.01)
	bcftools view -e 'TYPE!="snp"' $I | bcftools query -f '%CHROM\_%POS\_%REF\_%ALT\_b37[\t%DS]\n' | gzip - | cat - >> $OUTPUT

	NOW=$(date +%Y-%m-%d/%H:%M:%S)
	echo "Ending at $NOW"
done