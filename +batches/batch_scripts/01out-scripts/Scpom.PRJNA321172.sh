#!/bin/bash

mkdir ../annotations/Scpom.PRJNA321172
cd ../annotations/Scpom.PRJNA321172

echo Scpom.PRJNA321172


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3494745 SRR3494743 \
--conditions SRR3494745:A SRR3494743:A \
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


