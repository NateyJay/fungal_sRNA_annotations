#!/bin/bash

mkdir ../annotations/Asfla.PRJNA272148
cd ../annotations/Asfla.PRJNA272148

echo Asfla.PRJNA272148


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1748133 \
--conditions SRR1748133:A \
--genome_file ../../Genomes/Asfla.GCA_014117465.1_ASM1411746v1_genomic.fa

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


