#!/bin/bash

mkdir ../annotations/Scpom.PRJNA361034
cd ../annotations/Scpom.PRJNA361034

echo Scpom.PRJNA361034


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5168055 \
--conditions SRR5168055:A \
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


