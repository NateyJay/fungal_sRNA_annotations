#!/bin/bash

mkdir ../annotations/Tamar.PRJNA647397
cd ../annotations/Tamar.PRJNA647397

echo Tamar.PRJNA647397


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR12271078 SRR12271079 SRR12271080 \
--conditions SRR12271078:A SRR12271079:A SRR12271080:A \
--genome_file ../../Genomes/Tamar.GCF_009556855.1_ASM955685v1_genomic.fa

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


