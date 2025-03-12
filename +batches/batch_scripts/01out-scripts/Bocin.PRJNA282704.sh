#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282704
cd ../annotations/Bocin.PRJNA282704

echo Bocin.PRJNA282704


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3130005 SRR2002965 \
--conditions SRR3130005:A SRR2002965:B \
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


