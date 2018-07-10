#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=GVCF_transcriptomes
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "C_26_CHAD" "C_27_CHAD" "C_28_SOS" "C_29_SOS" "C_30_SOS" "C_31_Ocean" "C_32_Ocean" "C_33_Ocean" "C_34_Site5" "C_35_Site5" "C_36_Site5" "C_37_LA" "L_38_TX" "L_39_GA"

do

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar   -T HaplotypeCaller \
 -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
 -I /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Analysis_ready/$i.bam \
 -dontUseSoftClippedBases \
 -o /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/VCFs/$i.g.vcf \
 -ERC GVCF
 
done
