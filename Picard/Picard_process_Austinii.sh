#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=Picard_pipeline_Austinii
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar CleanSam \
      I=/work/rausher/Transcriptome_data_May_2016/Alignment/STAR/Output/All_individuals/11-23_2pass_A_74_Au2.2Aligned.out.sam \
      O=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/11-23_2pass_A_74_Au2.2AlignedCleaned.out.sam \



java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar AddOrReplaceReadGroups \
      I=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/11-23_2pass_A_74_Au2.2AlignedCleaned.out.sam \
	  O=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/A_74_Au2.2Aligned_RG_sorted.bam \
      SO=coordinate \
	  RGID=LANE1 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=$i

	  
java -jar picard.jar MarkDuplicates I=rg_added_sorted.bam O=dedupped.bam  

java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar MarkDuplicates \
I=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/A_74_Au2.2Aligned_RG_sorted.bam \
O=/work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Picard_processing/A_74_Au2.2dedupped.bam \
CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=A_74_Au2.2_output.metrics 
