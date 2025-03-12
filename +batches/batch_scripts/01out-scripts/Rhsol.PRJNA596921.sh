#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA596921
cd ../annotations/Rhsol.PRJNA596921

echo Rhsol.PRJNA596921


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10747099 SRR10747102 \
--conditions SRR10747099:A SRR10747102:A \
--genome_file ../../Genomes/Rhsol.GCA_016906535.1_ASM1690653v1_genomic.fa

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


