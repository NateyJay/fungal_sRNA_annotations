#!/bin/bash

mkdir ../annotations/Scpom.PRJNA229167
cd ../annotations/Scpom.PRJNA229167

echo Scpom.PRJNA229167


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1032901 SRR1032901 \
--conditions SRR1032901:A SRR1032901:A \
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


