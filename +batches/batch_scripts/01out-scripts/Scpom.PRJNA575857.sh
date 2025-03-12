#!/bin/bash

mkdir ../annotations/Scpom.PRJNA575857
cd ../annotations/Scpom.PRJNA575857

echo Scpom.PRJNA575857


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10231453 \
--conditions SRR10231453:A \
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


