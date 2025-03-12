#!/bin/bash

mkdir ../annotations/Focan.PRJNA705837
cd ../annotations/Focan.PRJNA705837

echo Focan.PRJNA705837


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR13823661 \
--conditions SRR13823661:A \
--genome_file ../../Genomes/Focan.GCA_002217175.1_ASM221717v1_genomic.fa

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


