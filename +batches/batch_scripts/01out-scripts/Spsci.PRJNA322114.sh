#!/bin/bash

mkdir ../annotations/Spsci.PRJNA322114
cd ../annotations/Spsci.PRJNA322114

echo Spsci.PRJNA322114


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3546731 SRR3546721 \
--conditions SRR3546731:A SRR3546721:A \
--genome_file ../../Genomes/Spsci.GCA_001010845.1_ASM101084v1_genomic.fa

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


