#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_transcriptomesL003
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "C_48_GA" "L_50_KY" "C_51_MX" "C_52_MX" "C_53_TX" "L_54_Kent" "L_55_Kent" "L_56_Kent" "L_57_KS" "L_58_KS" "L_64_KS" "L_65_POL" "L_66_POL" "C_67_POL" "C_68_POL" "C_69_POL" "C_71_Tabasco1" "C_72_Tabasco2" "C_73_Austin" "A_74_Au2.2"

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