#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=GVCF_transcriptomes
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_1_LTS" "L_2_LTS" "L_3_LTS" "L_4_CCF" "L_5_CCF" "L_6_CCF" "L_7_PCB" "L_8_PCB" "L_9_PCB" "C_10_CCR" "C_11_CCR"

do

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar   -T HaplotypeCaller \
 -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
 -I /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Analysis_ready/$i.bam \
 -dontUseSoftClippedBases \
 -o /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/VCFs/$i.g.vcf \
 -ERC GVCF
 
done
