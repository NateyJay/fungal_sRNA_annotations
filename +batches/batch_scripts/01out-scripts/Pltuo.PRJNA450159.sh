#!/bin/bash

mkdir ../annotations/Pltuo.PRJNA450159
cd ../annotations/Pltuo.PRJNA450159

echo Pltuo.PRJNA450159


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7003639 \
--conditions SRR7003639:B \
--genome_file ../../Genomes/Pltuo.GCA_036872985.1_ASM3687298v1_genomic.fa

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


