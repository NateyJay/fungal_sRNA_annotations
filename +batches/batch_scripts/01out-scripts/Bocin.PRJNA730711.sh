#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14576256 SRR14576255 SRR14576254 SRR14576253 SRR14576252 SRR14576251 \
--conditions SRR14576256:A SRR14576255:B SRR14576254:C SRR14576253:D SRR14576252:E SRR14576251:F \
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


