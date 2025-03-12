#!/bin/bash

mkdir ../annotations/Scscl.PRJNA361523
cd ../annotations/Scscl.PRJNA361523

echo Scscl.PRJNA361523


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5181384 SRR5180343 \
--conditions SRR5181384:A SRR5180343:B \
--genome_file ../../Genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.fa

echo "
downloading..."
yasma.py download -o .

echo "
finding adapters..."
yasma.py adapter -o .

echo "
trimming..."
yasma.py trim -o . --cores 28

echo "
aligning..."
yasma.py align -o . --cores 28


