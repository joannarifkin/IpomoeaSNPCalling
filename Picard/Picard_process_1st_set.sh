#!/bin/bash
#
#SBATCH --mem=65000
#SBATCH --job-name=Pic1
#SBATCH -p rausherlab
#SBATCH --mail-user=ac407
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5



export PATH=/opt/apps/slurm/java/jdk1.8.0_60/jre/bin:$PATH
export SAMPATH=/work/rausher/ac407/xtomeV2/alignment/star/170209/sj_run
export PICARDPATH=/work/rausher/ac407/xtomeV2/picard_preprocessing/170214

for i in "C_10_CCR_L1-10_" "C_11_CCR_L1-11_" "C_12_CCR_L1-12_" "C_19_Site1_L1-19_" "C_20_Site1_L1-20_" "C_21_Site1_L1-21_" "C_25_CHAD_L2-1_" "C_26_CHAD_L2-2_" "C_27_CHAD_L2-3_" "C_28_SOS_L2-4_" "C_29_SOS_L2-5_" "C_30_SOS_L2-6_" "C_31_Ocean_L2-7_" "C_32_Ocean_L2-8_" "C_33_Ocean_L2-9_" "C_34_Site5_L2-10_" "C_35_Site5_L2-11_" "C_36_Site5_L2-12_" "C_37_LA_L2-13_" "C_44_Tobasco1_L2-17_" "C_46_TX_L2-18_" "C_48_GA_L3-15_" "C_51_Tobasco2_L3-17_" "C_52_TX_L3-18_" "C_67_POL_L3-8_" "C_68_POL_L3-9_" "C_69_POL_L3-10_" "C_71_Tabasco1_L3-11_" "C_72_Tabasco2_L3-12_" "C_73_Austin_L3-13_" "W_43_LA_L2-16_"
do

echo "Processing sample $i ..."

# Clean up sam file reads that don't map
java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar CleanSam \
    I=$SAMPATH/sj_$i\Aligned.out.sam \
    O=$PICARDPATH/$i\AlignedCleaned.out.sam \


# Will add or replace read group
# This tool enables the user to replace all read groups in the INPUT file with a single new read group and assign all reads to this read group in the OUTPUT BAM file.
# SO is the sort order
java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar AddOrReplaceReadGroups \
    I=$PICARDPATH/$i\AlignedCleaned.out.sam \
    O=$PICARDPATH/$i\Aligned_RG_sorted.bam \
    SO=coordinate \
    RGID=LANE1 \
    RGLB=lib1 \
    RGPL=illumina \
    RGPU=unit1 \
    RGSM=$i

# MarkDuplicate reads for the GATK pipepline so they can be ignored and not use up unecessary computation time
java -jar /dscrhome/jlr42/picard-tools-2.5.0/picard.jar MarkDuplicates \
    I=$PICARDPATH/$i\Aligned_RG_sorted.bam \
    O=$PICARDPATH/$i\dedupped.bam \
    CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=$i\_output.metrics

done
