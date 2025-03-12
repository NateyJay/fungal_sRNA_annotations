#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA429556
cd ../annotations/Rhirr.PRJNA429556

echo Rhirr.PRJNA429556


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6473125 SRR6473120 SRR6473126 SRR6473123 SRR6473122 SRR6473124 \
--conditions SRR6473125:A SRR6473120:A SRR6473126:A SRR6473123:B SRR6473122:B SRR6473124:B \
--genome_file ../../Genomes/Rhirr.GCF_000439145.1_ASM43914v3_genomic.fa

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


