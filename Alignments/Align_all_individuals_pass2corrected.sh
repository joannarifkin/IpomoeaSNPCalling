#!/bin/bash
#
#SBATCH --mem=100000
#SBATCH --job-name=align_all_individuals
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

#This script aligns all of the samples to the lacunosa genome with 2-pass splice junctions generated from all the samples using STAR

export LD_LIBRARY_PATH=/opt/apps/slurm/gcc-4.9.2/lib64:$LD_LIBRARY_PATH
export PATH=/opt/apps/slurm/gcc-4.9.2/bin:$PATH

for i in "C_10_CCR_L1-10_" "C_11_CCR_L1-11_" "C_12_CCR_L1-12_" "C_19_Site1_L1-19_" "C_20_Site1_L1-20_" "C_21_Site1_L1-21_" "C_25_CHAD_L2-1_" "C_26_CHAD_L2-2_" "C_27_CHAD_L2-3_" "C_28_SOS_L2-4_" "C_29_SOS_L2-5_" "C_30_SOS_L2-6_" "C_31_Ocean_L2-7_" "C_32_Ocean_L2-8_" "C_33_Ocean_L2-9_" "C_34_Site5_L2-10_" "C_35_Site5_L2-11_" "C_36_Site5_L2-12_" "C_37_LA_L2-13_" "C_44_Tobasco1_L2-17_" "C_46_TX_L2-18_" "C_48_GA_L3-15_" "C_51_Tobasco2_L3-17_" "C_52_TX_L3-18_" "C_67_POL_L3-8_" "C_68_POL_L3-9_" "C_69_POL_L3-10_" "C_71_Tabasco1_L3-11_" "C_72_Tabasco2_L3-12_" "C_73_Austin_L3-13_" "W_43_LA_L2-16_" "L_13_CCR_L1-13_" "L_14_CCR_L1-14_" "L_15_CCR_L1-15_" "L_16_Site1_L1-16_" "L_17_Site1_L1-17_" "L_18_Site1_L1-18_" "L_1_LTS_L1-1_" "L_22_CHAD_L2-19_" "L_23_CHAD_L2-20_" "L_24_CHAD_L2-21_" "L_2_LTS_L1-2_" "L_38_TX_L2-14_" "L_39_GA_L2-15_" "L_3_LTS_L1-8_" "L_4_CCF_L1-4_" "L_50_KY_L3-16_" "L_53_Kent_L3-19_" "L_54_Kent_L3-20_" "L_55_Kent_L3-1_" "L_56_KS_L3-2_" "L_57_KS_L3-3_" "L_58_KS_L3-4_" "L_5_CCF_L1-5_" "L_64_POL_L3-5_" "L_65_POL_L3-6_" "L_66_POL_L3-7_" "L_6_CCF_L1-6_" "L_7_PCB_L1-7_" "L_8_PCB_L1-3_" "L_9_PCB_L1-9_" "A_74_Au2.2_L3-14_"

do

STAR --genomeDir /work/rausher/lacunosa_ref/ \
--readFilesCommand zcat \
--readFilesIn /work/rausher/Corrected_transcriptome_jan_2017/$i\R1.fastq.gz \
/work/rausher/Corrected_transcriptome_jan_2017/$i\R2.fastq.gz \
--outFileNamePrefix /work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-24_pass2_$i \
--sjdbFileChrStartEnd \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_10_CCR_L1-10_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_11_CCR_L1-11_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_12_CCR_L1-12_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_19_Site1_L1-19_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_20_Site1_L1-20_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_21_Site1_L1-21_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_25_CHAD_L2-1_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_26_CHAD_L2-2_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_27_CHAD_L2-3_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_28_SOS_L2-4_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_29_SOS_L2-5_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_30_SOS_L2-6_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_31_Ocean_L2-7_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_32_Ocean_L2-8_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_33_Ocean_L2-9_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_34_Site5_L2-10_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_35_Site5_L2-11_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_36_Site5_L2-12_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_37_LA_L2-13_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_44_Tobasco1_L2-17_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_46_TX_L2-18_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_48_GA_L3-15_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_51_Tobasco2_L3-17_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_52_TX_L3-18_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_67_POL_L3-8_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_68_POL_L3-9_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_69_POL_L3-10_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_71_Tabasco1_L3-11_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_72_Tabasco2_L3-12_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_C_73_Austin_L3-13_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_W_43_LA_L2-16_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_13_CCR_L1-13_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_14_CCR_L1-14_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_15_CCR_L1-15_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_16_Site1_L1-16_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_17_Site1_L1-17_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_18_Site1_L1-18_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_1_LTS_L1-1_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_22_CHAD_L2-19_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_23_CHAD_L2-20_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_24_CHAD_L2-21_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_2_LTS_L1-2_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_38_TX_L2-14_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_39_GA_L2-15_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_3_LTS_L1-8_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_4_CCF_L1-4_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_50_KY_L3-16_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_53_Kent_L3-19_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_54_Kent_L3-20_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_55_Kent_L3-1_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_56_KS_L3-2_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_57_KS_L3-3_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_58_KS_L3-4_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_5_CCF_L1-5_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_64_POL_L3-5_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_65_POL_L3-6_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_66_POL_L3-7_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_6_CCF_L1-6_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_7_PCB_L1-7_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_8_PCB_L1-3_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_L_9_PCB_L1-9_SJ.out.tab \
/work/rausher/Corrected_transcriptome_jan_2017/Alignment/STAR/Output/All/LacunosaRef/1-23_A_74_Au2.2_L3-14_SJ.out.tab \

--runThreadN 16

done