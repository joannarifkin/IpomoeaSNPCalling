#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_transcriptomesL001
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_1_LTS_L1-1_" "C_10_CCR_L1-10_" "C_11_CCR_L1-11_" "C_12_CCR_L1-12_" "L_13_CCR_L1-13_" "L_14_CCR_L1-14_" "L_15_CCR_L1-15_" "L_16_Site1_L1-16_" "L_17_Site1_L1-17_" "L_18_Site1_L1-18_" "C_19_Site1_L1-19_" "L_2_LTS_L1-2_" "C_20_Site1_L1-20_" "C_21_Site1_L1-21_" "L_8_PCB_L1-3_" "L_4_CCF_L1-4_" "L_5_CCF_L1-5_" "L_6_CCF_L1-6_" "L_7_PCB_L1-7_" "L_3_LTS_L1-8_" "L_9_PCB_L1-9_"

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
	  TMP_DIR=`pwd`/tmp1


java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar MarkDuplicates \
I=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
O=/work/rausher/Corrected_transcriptome_jan_2017/GATK_pipeline/Picard_processing/$i\dedupped.bam \
CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=$i\_output.metrics \
TMP_DIR=`pwd`/tmp1


done 