#!/bin/bash
#
#SBATCH --mem=115000
#SBATCH --job-name=
#SBATCH -p rausherlab
#SBATCH --mail-user=ac407
#SBATCH --mail-type=ALL
#SBATCH --nodelist=dcc-rausherlab-01
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5

# This script filters the Combined SNP gVCF for QD (quality) and DP (depth)


export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH
export INPATH=/work/rausher/ac407/xtomeV2/gatk/filtering/sep_SNP_INDELS
export DPPATH=/work/rausher/ac407/xtomeV2/gatk/filtering/filtered_vcfs

# infile: JG_lac_ref_raw_snps.vcf


java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
    -T VariantFiltration \
    -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
    -V $INPATH/JG_lac_ref_raw_snps.vcf \
    -window 35 -cluster 3 -filterName FS -filter "FS > 30.0" -filterName QD -filter "QD < 2.0" \
    --genotypeFilterExpression "DP < 10" \
    --genotypeFilterName "lowDP" \
    -o $DPPATH/dp_snpstemp1.vcf

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
    -T VariantFiltration \
    -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
    -V $DPPATH/dp_snpstemp1.vcf \
    --setFilteredGtToNocall \
    -o $DPPATH/dp_snpstemp2.vcf

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
    -T VariantFiltration \
    -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
    -V $DPPATH/dp_snpstemp2.vcf \
    --filterExpression "AN < 120" \
    --filterName "lowAN" \
    -o $DPPATH/dp_snpstemp3.vcf

# vc is the VariantContext object from Picard Tools which GATK uses, which allows use of more complex JEXL expressions
java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
    -T SelectVariants \
    -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
    -V $DPPATH/dp_snpstemp3.vcf \
    -select ' vc.isBiallelic() ? AF > 0.0 : vc.hasGenotypes()  && vc.getCalledChrCount(vc.getAltAlleleWithHighestAlleleCount())/(1.0*vc.getCalledChrCount()) > 0.0 ' \
    -o $DPPATH/dp_snpstemp4.vcf \
    -env \
    -ef

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
    -T SelectVariants \
    -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
    -V $DPPATH/dp_snpstemp4.vcf \
    -select ' vc.isBiallelic() ? AF < 1.0 : vc.hasGenotypes() && vc.getCalledChrCount(vc.getAltAlleleWithHighestAlleleCount())/(1.0*vc.getCalledChrCount()) < 1.0 ' \
    -o $DPPATH/JG_LacRef_QD_DP_XTOME_SNPS.vcf \
    -env \
    -ef

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
    -T VariantsToTable \
    -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
    -V $DPPATH/JG_LacRef_QD_DP_XTOME_SNPS.vcf \
    -F CHROM -F POS -F TYPE -F MULTI-ALLELIC -F REF -F ALT \
    -F NCALLED -F AC -F AF -F HOM-REF -F HOM-VAR -F HET \
    -F QUAL -F MQ  \
    -GF GT \
    --allowMissingData \
    -o $DPPATH/JG_LacRef_QD_DP_XTOME_SNPS.table
