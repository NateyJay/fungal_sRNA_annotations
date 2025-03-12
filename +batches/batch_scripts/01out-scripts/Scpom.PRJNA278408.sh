#!/bin/bash

mkdir ../annotations/Scpom.PRJNA278408
cd ../annotations/Scpom.PRJNA278408

echo Scpom.PRJNA278408


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1916774 SRR1916773 SRR1916772 SRR1916771 \
--conditions SRR1916774:A SRR1916773:A SRR1916772:A SRR1916771:A \
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


