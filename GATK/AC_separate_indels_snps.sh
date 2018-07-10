#!/bin/bash
#
#SBATCH --mem=115000
#SBATCH --job-name=SpltSNPINDELS
#SBATCH -p rausherlab
#SBATCH --mail-user=ac407
#SBATCH --mail-type=ALL
#SBATCH --nodelist=dcc-rausherlab-01
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5


# From the combined, unfiltered joint-genotyped GVCF file:
# Separate the SNPS from the INDELS and place them into separate files

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH
export COMBGVCFPATH=/work/rausher/ac407/xtomeV2/gatk/filtering/combineGVCFs
export SEPPATH=/work/rausher/ac407/xtomeV2/gatk/filtering/sep_SNP_INDELS

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
  -T SelectVariants \
  -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
  -V $COMBGVCFPATH/combined_unfiltered_GVCFs.vcf \
  -selectType SNP \
  -o $SEPPATH/JG_lac_ref_raw_snps.vcf \
  -nt 5

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
  -T SelectVariants \
  -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
  -V $COMBGVCFPATH/combined_unfiltered_GVCFs.vcf \
  -selectType INDEL \
  -o $SEPPATH/JG_lac_ref_raw_indels.vcf \
  -nt 5
