#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_transcriptomesL002
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_22_CHAD" "L_23_CHAD" "L_24_CHAD" "C_25_CHAD" "C_26_CHAD" "C_27_CHAD" "C_28_SOS" "C_29_SOS" "C_30_SOS" "C_31_Ocean" "C_32_Ocean" "C_33_Ocean" "C_34_Site5" "C_35_Site5" "C_36_Site5" "C_37_LA" "L_38_TX" "L_39_GA" "W_43_LA" "C_44_MX" "C_46_TX"

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