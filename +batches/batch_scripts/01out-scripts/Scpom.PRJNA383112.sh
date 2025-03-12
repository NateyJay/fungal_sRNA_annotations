#!/bin/bash

mkdir ../annotations/Scpom.PRJNA383112
cd ../annotations/Scpom.PRJNA383112

echo Scpom.PRJNA383112


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5453498 \
--conditions SRR5453498:A \
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


