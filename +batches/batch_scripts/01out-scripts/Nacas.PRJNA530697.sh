#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530697
cd ../annotations/Nacas.PRJNA530697

echo Nacas.PRJNA530697


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9710748 \
--conditions SRR9710748:A \
--genome_file ../../Genomes/Nacas.GCA_000237345.1_ASM23734v1_genomic.fa

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


