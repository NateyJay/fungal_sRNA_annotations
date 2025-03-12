#!/bin/bash

mkdir ../annotations/Bocin.PRJNA253747
cd ../annotations/Bocin.PRJNA253747

echo Bocin.PRJNA253747


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1482408 \
--conditions SRR1482408:A \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


