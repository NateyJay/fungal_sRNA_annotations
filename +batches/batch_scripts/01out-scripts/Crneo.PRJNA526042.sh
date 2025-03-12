#!/bin/bash

mkdir ../annotations/Crneo.PRJNA526042
cd ../annotations/Crneo.PRJNA526042

echo Crneo.PRJNA526042


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8697600 SRR8697601 \
--conditions SRR8697600:A SRR8697601:A \
--genome_file ../../Genomes/Crneo.GCA_000091045.1_ASM9104v1_genomic.fa

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


