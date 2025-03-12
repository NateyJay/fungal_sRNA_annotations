#!/bin/bash

mkdir ../annotations/Scpom.PRJNA235985
cd ../annotations/Scpom.PRJNA235985

echo Scpom.PRJNA235985


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1137061 SRR1137061 \
--conditions SRR1137061:A SRR1137061:A \
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


