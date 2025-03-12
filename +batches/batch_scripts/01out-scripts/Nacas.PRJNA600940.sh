#!/bin/bash

mkdir ../annotations/Nacas.PRJNA600940
cd ../annotations/Nacas.PRJNA600940

echo Nacas.PRJNA600940


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10877422 SRR10877419 \
--conditions SRR10877422:A SRR10877419:B \
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


