#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8501350 SRR8501349 SRR8501348 \
--conditions SRR8501350:A SRR8501349:B SRR8501348:C \
--genome_file ../../Genomes/Bebas.GCA_000280675.1_ASM28067v1_genomic.fa

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


