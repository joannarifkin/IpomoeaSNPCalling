#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_transcriptomesL002
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "C_25_CHAD_L2-1_" "C_34_Site5_L2-10_" "C_35_Site5_L2-11_" "C_36_Site5_L2-12_" "C_37_LA_L2-13_" "L_38_TX_L2-14_" "L_39_GA_L2-15_" "W_43_LA_L2-16_" "C_44_Tobasco1_L2-17_" "C_46_TX_L2-18_" "L_22_CHAD_L2-19_" "C_26_CHAD_L2-2_" "L_23_CHAD_L2-20_" "L_24_CHAD_L2-21_" "C_27_CHAD_L2-3_" "C_28_SOS_L2-4_" "C_29_SOS_L2-5_" "C_30_SOS_L2-6_" "C_31_Ocean_L2-7_" "C_32_Ocean_L2-8_" "C_33_Ocean_L2-9_"

do

echo "Processing sample $i ..."

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar CleanSam \
      I=/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/TrifidaRef/1-25_pass2_$i\Aligned.out.sam\
      O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/1-27_$i\AlignedCleaned.out.sam \



java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar AddOrReplaceReadGroups \
      I=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/1-27_$i\AlignedCleaned.out.sam \
	  O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
	  SO=coordinate \
      RGID=LANE1 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=$i \
	  TMP_DIR=`pwd`/tmp2


java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar MarkDuplicates \
I=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\dedupped.bam \
CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=$i\_output.metrics 


done 