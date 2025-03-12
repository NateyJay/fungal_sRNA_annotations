#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253153
cd ../annotations/Fugra.PRJNA253153

echo Fugra.PRJNA253153


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1427176 \
--conditions SRR1427176:A \
--genome_file ../../Genomes/Fugra.GCF_000240135.3_ASM24013v3_genomic.fa

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


