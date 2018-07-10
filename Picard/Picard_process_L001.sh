#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_transcriptomesL001
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_1_LTS" "L_2_LTS" "L_3_LTS" "L_4_CCF" "L_5_CCF" "L_6_CCF" "L_7_PCB" "L_8_PCB" "L_9_PCB" "C_10_CCR" "C_11_CCR" "C_12_CCR" "L_13_CCR" "L_14_CCR" "L_15_CCR" "L_16_Site1" "L_17_Site1" "L_18_Site1" "C_19_Site1" "C_20_Site1" "C_21_Site1" 

do

echo "Processing sample $i ..."

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar CleanSam \
      I=/work/rausher/Transcriptome_data_May_2016/Alignment/STAR/Output/All_individuals/11-23_$i\Aligned.out.sam \
      O=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/11-23_$i\AlignedCleaned.out.sam \



java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar AddOrReplaceReadGroups \
      I=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/11-23_$i\AlignedCleaned.out.sam \
	  O=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
	  SO=coordinate \
      RGID=LANE1 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=$i

	  
java -jar picard.jar MarkDuplicates I=rg_added_sorted.bam O=dedupped.bam  

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar MarkDuplicates \
I=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/$i\Aligned_RG_sorted.bam \
O=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/$i\dedupped.bam \
CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=$i\_output.metrics 



done 