#!/bin/bash

mkdir ../annotations/Scpom.PRJNA727318
cd ../annotations/Scpom.PRJNA727318

echo Scpom.PRJNA727318


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14420089 \
--conditions SRR14420089:A \
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


