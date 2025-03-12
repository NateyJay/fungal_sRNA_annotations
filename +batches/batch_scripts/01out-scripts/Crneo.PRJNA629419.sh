#!/bin/bash

mkdir ../annotations/Crneo.PRJNA629419
cd ../annotations/Crneo.PRJNA629419

echo Crneo.PRJNA629419


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR11648392 \
--conditions SRR11648392:A \
--genome_file ../../Genomes/Crneo.GCA_000091045.1_ASM9104v1_genomic.fa

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


