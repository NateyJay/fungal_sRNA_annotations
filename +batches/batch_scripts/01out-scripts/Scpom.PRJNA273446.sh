#!/bin/bash

mkdir ../annotations/Scpom.PRJNA273446
cd ../annotations/Scpom.PRJNA273446

echo Scpom.PRJNA273446


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1770409 \
--conditions SRR1770409:Z.d1 \
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


