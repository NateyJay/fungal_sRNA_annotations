#!/bin/bash

mkdir ../annotations/Asfla.PRJNA816993
cd ../annotations/Asfla.PRJNA816993

echo Asfla.PRJNA816993


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR24124426 SRR24124427 SRR24124425 SRR24124430 SRR24124429 SRR24124428 \
--conditions SRR24124426:A SRR24124427:A SRR24124425:A SRR24124430:B SRR24124429:B SRR24124428:B \
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


