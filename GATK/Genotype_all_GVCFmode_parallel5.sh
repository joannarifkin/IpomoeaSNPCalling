#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=GVCF_transcriptomes
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_65_POL" "L_66_POL" "C_67_POL" "C_68_POL" "C_69_POL" "C_71_Tabasco1" "C_72_Tabasco2" "C_73_Austin" "A_74_Au2.2"

do

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar   -T HaplotypeCaller \
 -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
 -I /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Analysis_ready/$i.bam \
 -dontUseSoftClippedBases \
 -o /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/VCFs/$i.g.vcf \
 -ERC GVCF
 
done
