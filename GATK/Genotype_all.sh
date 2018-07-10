#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=VCF_transcriptomes
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH 

for i in "L_1_LTS" "L_2_LTS" "L_3_LTS" "L_4_CCF" "L_5_CCF" "L_6_CCF" "L_7_PCB" "L_8_PCB" "L_9_PCB" "C_10_CCR" "C_11_CCR" "C_12_CCR" "L_13_CCR" "L_14_CCR" "L_15_CCR" "L_16_Site1" "L_17_Site1" "L_18_Site1" "C_19_Site1" "C_20_Site1" "C_21_Site1" "L_22_CHAD" "L_23_CHAD" "L_24_CHAD" "C_25_CHAD" "C_26_CHAD" "C_27_CHAD" "C_28_SOS" "C_29_SOS" "C_30_SOS" "C_31_Ocean" "C_32_Ocean" "C_33_Ocean" "C_34_Site5" "C_35_Site5" "C_36_Site5" "C_37_LA" "L_38_TX" "L_39_GA" "W_43_LA" "C_44_MX" "C_46_TX" "C_48_GA" "L_50_KY" "C_51_MX" "C_52_MX" "C_53_TX" "L_54_Kent" "L_55_Kent" "L_56_Kent" "L_57_KS" "L_58_KS" "L_64_KS" "L_65_POL" "L_66_POL" "C_67_POL" "C_68_POL" "C_69_POL" "C_71_Tabasco1" "C_72_Tabasco2" "C_73_Austin" "A_74_Au2.2"

do

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar   -T HaplotypeCaller \
 -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
 -I /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/Analysis_ready/$i.bam \
 -dontUseSoftClippedBases \
 -stand_call_conf 20.0 \
 -stand_emit_conf 20.0 \
 -o /work/rausher/Transcriptome_data_May_2016/GATK_pipeline/VCFs/$i.vcf
 
done
