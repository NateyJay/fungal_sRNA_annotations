#!/bin/bash

mkdir ../annotations/Rasol.PRJNA213313
cd ../annotations/Rasol.PRJNA213313

echo Rasol.PRJNA213313


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR943041 \
--conditions SRR943041:B \
--genome_file ../../Genomes/Rasol.GCF_021117135.1_ASM2111713v1_genomic.fa

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


