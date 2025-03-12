#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR2970501 SRR3055828 SRR3055829 SRR3055827 \
--conditions SRR2970501:A SRR3055828:B SRR3055829:C SRR3055827:D \
--genome_file ../../Genomes/Fugra.GCF_000240135.3_ASM24013v3_genomic.fa

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


