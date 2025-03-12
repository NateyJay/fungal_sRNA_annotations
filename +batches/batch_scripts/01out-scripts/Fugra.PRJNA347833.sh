#!/bin/bash

mkdir ../annotations/Fugra.PRJNA347833
cd ../annotations/Fugra.PRJNA347833

echo Fugra.PRJNA347833


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR4415737 \
--conditions SRR4415737:A \
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


