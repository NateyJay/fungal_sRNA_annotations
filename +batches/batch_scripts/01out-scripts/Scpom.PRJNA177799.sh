#!/bin/bash

mkdir ../annotations/Scpom.PRJNA177799
cd ../annotations/Scpom.PRJNA177799

echo Scpom.PRJNA177799


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR593453 \
--conditions SRR593453:A \
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


