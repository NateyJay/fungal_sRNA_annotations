#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322452
cd ../annotations/Scpom.PRJNA322452

echo Scpom.PRJNA322452


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3570942 SRR3570943 \
--conditions SRR3570942:A SRR3570943:A \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


