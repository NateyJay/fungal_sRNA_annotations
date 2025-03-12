#!/bin/bash

mkdir ../annotations/Scpom.PRJNA122193
cd ../annotations/Scpom.PRJNA122193

echo Scpom.PRJNA122193


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR035947 \
--conditions SRR035947:A \
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


