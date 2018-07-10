#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_transcriptomesL003
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_55_Kent_L3-1_" "C_69_POL_L3-10_" "C_71_Tabasco1_L3-11_" "C_72_Tabasco2_L3-12_" "C_73_Austin_L3-13_" "A_74_Au2.2_L3-14_" "C_48_GA_L3-15_" "L_50_KY_L3-16_" "C_51_Tobasco2_L3-17_" "C_52_TX_L3-18_" "L_53_Kent_L3-19_" "L_56_KS_L3-2_" "L_54_Kent_L3-20_" "L_57_KS_L3-3_" "L_58_KS_L3-4_" "L_64_POL_L3-5_" "L_65_POL_L3-6_" "L_66_POL_L3-7_" "C_67_POL_L3-8_" "C_68_POL_L3-9_"
do

echo "Processing sample $i ..."

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar CleanSam \
      I=/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/TrifidaRef/1-25_pass2_$i\Aligned.out.sam\
      O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/1-27_$i\AlignedCleaned.out.sam \



java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar AddOrReplaceReadGroups \
      I=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/1-27_$i\AlignedCleaned.out.sam \
	  O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
	  SO=coordinate \
      RGID=LANE3 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=$i \
	  TMP_DIR=temp3

	  

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar MarkDuplicates \
I=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\dedupped.bam \
CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=$i\_output.metrics 



done 