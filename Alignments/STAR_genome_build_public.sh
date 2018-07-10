#!/bin/bash
#
#SBATCH --mem=50000
#SBATCH --job-name=STAR_index_genome
#SBATCH -p rausherlab 
#SBATCH --mail-user=jlr42
#SBATCH --mail-type=ALL

STAR --runMode genomeGenerate --genomeDir /work/rausher/lacunosa_ref/ --genomeFastaFiles /work/rausher/lacunosa_ref/lacunosa_genome_070416.fasta --runThreadN 16 