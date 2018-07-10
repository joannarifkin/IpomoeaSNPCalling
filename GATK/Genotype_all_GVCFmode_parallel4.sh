#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=GVCF_transcriptomes
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "W_43_LA" "C_44_MX" "C_46_TX" "C_48_GA" "L_50_KY" "C_51_MX" "C_52_MX" "C_53_TX" "L_54_Kent" "L_55_Kent" "L_56_Kent" "L_57_KS" "L_58_KS" "L_64_KS"

do

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar   -T HaplotypeCaller \
 -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
 -I /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Analysis_ready/$i.bam \
 -dontUseSoftClippedBases \
 -o /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/VCFs/$i.g.vcf \
 -ERC GVCF
 
done
