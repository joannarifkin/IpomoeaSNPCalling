#!/bin/bash
#
#SBATCH --mem=115000
#SBATCH --job-name=CombGVCF
#SBATCH -p rausherlab
#SBATCH --mail-user=ac407
#SBATCH --mail-type=ALL
#SBATCH --nodelist=dcc-rausherlab-01




export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH
export GVCFPATH=/work/rausher/ac407/xtomeV2/gatk/haplotypecaller/170216

java -jar /dscrhome/jlr42/GenomeAnalysisTK.jar \
  -T GenotypeGVCFs \
  -R /dscrhome/jlr42/Ipomoea_sequence_data/PacBioSeq./piloncorrectedgenome.fasta \
  --variant $GVCFPATH/A_74_Au2.2_L3-14_.g.vcf \
	--variant $GVCFPATH/C_10_CCR_L1-10_.g.vcf \
	--variant $GVCFPATH/C_11_CCR_L1-11_.g.vcf \
	--variant $GVCFPATH/C_12_CCR_L1-12_.g.vcf \
	--variant $GVCFPATH/C_19_Site1_L1-19_.g.vcf \
	--variant $GVCFPATH/C_20_Site1_L1-20_.g.vcf \
	--variant $GVCFPATH/C_21_Site1_L1-21_.g.vcf \
	--variant $GVCFPATH/C_25_CHAD_L2-1_.g.vcf \
	--variant $GVCFPATH/C_26_CHAD_L2-2_.g.vcf \
	--variant $GVCFPATH/C_27_CHAD_L2-3_.g.vcf \
	--variant $GVCFPATH/C_28_SOS_L2-4_.g.vcf \
	--variant $GVCFPATH/C_29_SOS_L2-5_.g.vcf \
	--variant $GVCFPATH/C_30_SOS_L2-6_.g.vcf \
	--variant $GVCFPATH/C_31_Ocean_L2-7_.g.vcf \
	--variant $GVCFPATH/C_32_Ocean_L2-8_.g.vcf \
	--variant $GVCFPATH/C_33_Ocean_L2-9_.g.vcf \
	--variant $GVCFPATH/C_34_Site5_L2-10_.g.vcf \
	--variant $GVCFPATH/C_35_Site5_L2-11_.g.vcf \
	--variant $GVCFPATH/C_36_Site5_L2-12_.g.vcf \
	--variant $GVCFPATH/C_37_LA_L2-13_.g.vcf \
	--variant $GVCFPATH/C_44_Tobasco1_L2-17_.g.vcf \
	--variant $GVCFPATH/C_46_TX_L2-18_.g.vcf \
	--variant $GVCFPATH/C_48_GA_L3-15_.g.vcf \
	--variant $GVCFPATH/C_51_Tobasco2_L3-17_.g.vcf \
	--variant $GVCFPATH/C_52_TX_L3-18_.g.vcf \
	--variant $GVCFPATH/C_67_POL_L3-8_.g.vcf \
	--variant $GVCFPATH/C_68_POL_L3-9_.g.vcf \
	--variant $GVCFPATH/C_69_POL_L3-10_.g.vcf \
	--variant $GVCFPATH/C_71_Tabasco1_L3-11_.g.vcf \
	--variant $GVCFPATH/C_72_Tabasco2_L3-12_.g.vcf \
	--variant $GVCFPATH/C_73_Austin_L3-13_.g.vcf \
	--variant $GVCFPATH/L_13_CCR_L1-13_.g.vcf \
	--variant $GVCFPATH/L_14_CCR_L1-14_.g.vcf \
	--variant $GVCFPATH/L_15_CCR_L1-15_.g.vcf \
	--variant $GVCFPATH/L_16_Site1_L1-16_.g.vcf \
	--variant $GVCFPATH/L_17_Site1_L1-17_.g.vcf \
	--variant $GVCFPATH/L_18_Site1_L1-18_.g.vcf \
	--variant $GVCFPATH/L_1_LTS_L1-1_.g.vcf \
	--variant $GVCFPATH/L_22_CHAD_L2-19_.g.vcf \
	--variant $GVCFPATH/L_23_CHAD_L2-20_.g.vcf \
	--variant $GVCFPATH/L_24_CHAD_L2-21_.g.vcf \
	--variant $GVCFPATH/L_2_LTS_L1-2_.g.vcf \
	--variant $GVCFPATH/L_38_TX_L2-14_.g.vcf \
	--variant $GVCFPATH/L_39_GA_L2-15_.g.vcf \
	--variant $GVCFPATH/L_3_LTS_L1-8_.g.vcf \
	--variant $GVCFPATH/L_4_CCF_L1-4_.g.vcf \
	--variant $GVCFPATH/L_50_KY_L3-16_.g.vcf \
	--variant $GVCFPATH/L_53_Kent_L3-19_.g.vcf \
	--variant $GVCFPATH/L_54_Kent_L3-20_.g.vcf \
	--variant $GVCFPATH/L_55_Kent_L3-1_.g.vcf \
	--variant $GVCFPATH/L_56_KS_L3-2_.g.vcf \
	--variant $GVCFPATH/L_57_KS_L3-3_.g.vcf \
	--variant $GVCFPATH/L_58_KS_L3-4_.g.vcf \
	--variant $GVCFPATH/L_5_CCF_L1-5_.g.vcf \
	--variant $GVCFPATH/L_64_POL_L3-5_.g.vcf \
	--variant $GVCFPATH/L_65_POL_L3-6_.g.vcf \
	--variant $GVCFPATH/L_66_POL_L3-7_.g.vcf \
	--variant $GVCFPATH/L_6_CCF_L1-6_.g.vcf \
	--variant $GVCFPATH/L_7_PCB_L1-7_.g.vcf \
	--variant $GVCFPATH/L_8_PCB_L1-3_.g.vcf \
	--variant $GVCFPATH/L_9_PCB_L1-9_.g.vcf \
	--variant $GVCFPATH/W_43_LA_L2-16_.g.vcf \
  -o /work/rausher/ac407/xtomeV2/gatk/filtering/combineGVCFs/combined_unfiltered_GVCFs.vcf
