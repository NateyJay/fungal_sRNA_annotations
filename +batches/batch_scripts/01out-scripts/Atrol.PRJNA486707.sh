#!/bin/bash

mkdir ../annotations/Atrol.PRJNA486707
cd ../annotations/Atrol.PRJNA486707

echo Atrol.PRJNA486707


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7754484 \
--conditions SRR7754484:A \
--genome_file ../../Genomes/Atrol.GCA_018343915.1_ASM1834391v1_genomic.fa

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


