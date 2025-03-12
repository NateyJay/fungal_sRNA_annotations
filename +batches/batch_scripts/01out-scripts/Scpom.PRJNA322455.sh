#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322455
cd ../annotations/Scpom.PRJNA322455

echo Scpom.PRJNA322455


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3571005 SRR3571006 \
--conditions SRR3571005:B SRR3571006:B \
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


