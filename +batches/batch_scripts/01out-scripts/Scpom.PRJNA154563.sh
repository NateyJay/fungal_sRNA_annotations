#!/bin/bash

mkdir ../annotations/Scpom.PRJNA154563
cd ../annotations/Scpom.PRJNA154563

echo Scpom.PRJNA154563


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR315118 SRR315117 \
--conditions SRR315118:Z.d1 SRR315117:A \
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


