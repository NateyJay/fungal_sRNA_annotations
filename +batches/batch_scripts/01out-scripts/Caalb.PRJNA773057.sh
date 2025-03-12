#!/bin/bash

mkdir ../annotations/Caalb.PRJNA773057
cd ../annotations/Caalb.PRJNA773057

echo Caalb.PRJNA773057


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR16501716 \
--conditions SRR16501716:A \
--genome_file ../../Genomes/Caalb.GCF_000182965.3_ASM18296v3_genomic.fa

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


