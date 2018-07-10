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

for i in "L_13_CCR_L1-13_" "L_14_CCR_L1-14_" "L_15_CCR_L1-15_" "L_16_Site1_L1-16_" "L_17_Site1_L1-17_" "L_18_Site1_L1-18_" "L_1_LTS_L1-1_" "L_22_CHAD_L2-19_" "L_23_CHAD_L2-20_" "L_24_CHAD_L2-21_" "L_2_LTS_L1-2_" "L_38_TX_L2-14_" "L_39_GA_L2-15_" "L_3_LTS_L1-8_" "L_4_CCF_L1-4_" "L_50_KY_L3-16_" "L_53_Kent_L3-19_" "L_54_Kent_L3-20_" "L_55_Kent_L3-1_" "L_56_KS_L3-2_" "L_57_KS_L3-3_" "L_58_KS_L3-4_" "L_5_CCF_L1-5_" "L_64_POL_L3-5_" "L_65_POL_L3-6_" "L_66_POL_L3-7_" "L_6_CCF_L1-6_" "L_7_PCB_L1-7_" "L_8_PCB_L1-3_" "L_9_PCB_L1-9_" "A_74_Au2.2_L3-14_"
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
