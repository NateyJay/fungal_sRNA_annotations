#!/bin/bash

mkdir ../annotations/Scpom.PRJNA369032
cd ../annotations/Scpom.PRJNA369032

echo Scpom.PRJNA369032


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5208761 \
--conditions SRR5208761:A \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


