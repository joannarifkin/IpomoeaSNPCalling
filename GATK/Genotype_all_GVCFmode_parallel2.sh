#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=GVCF_transcriptomes
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "C_12_CCR" "L_13_CCR" "L_14_CCR" "L_15_CCR" "L_16_Site1" "L_17_Site1" "L_18_Site1" "C_19_Site1" "C_20_Site1" "C_21_Site1" "L_22_CHAD" "L_23_CHAD" "L_24_CHAD" "C_25_CHAD"

do

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar   -T HaplotypeCaller \
 -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
 -I /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Analysis_ready/$i.bam \
 -dontUseSoftClippedBases \
 -o /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/VCFs/$i.g.vcf \
 -ERC GVCF
 
done
