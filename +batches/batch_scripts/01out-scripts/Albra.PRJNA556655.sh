#!/bin/bash

mkdir ../annotations/Albra.PRJNA556655
cd ../annotations/Albra.PRJNA556655

echo Albra.PRJNA556655


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9833419 SRR9833418 \
--conditions SRR9833419:A SRR9833418:B \
--genome_file ../../Genomes/Albra.GCA_002796735.1_ASM279673v1_genomic.fa

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


