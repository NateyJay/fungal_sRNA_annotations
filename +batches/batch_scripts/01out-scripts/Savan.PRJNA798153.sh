#!/bin/bash

mkdir ../annotations/Savan.PRJNA798153
cd ../annotations/Savan.PRJNA798153

echo Savan.PRJNA798153


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR17649062 SRR17649063 \
--conditions SRR17649062:A SRR17649063:B \
--genome_file ../../Genomes/Savan.GCA_024703735.1_ASM2470373v1_genomic.fa

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


