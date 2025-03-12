#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA213313
cd ../annotations/Rhirr.PRJNA213313

echo Rhirr.PRJNA213313


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR943039 \
--conditions SRR943039:C \
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


