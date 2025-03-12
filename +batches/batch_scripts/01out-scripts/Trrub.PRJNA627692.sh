#!/bin/bash

mkdir ../annotations/Trrub.PRJNA627692
cd ../annotations/Trrub.PRJNA627692

echo Trrub.PRJNA627692


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR11599830 SRR11599828 SRR11599829 \
--conditions SRR11599830:A SRR11599828:A SRR11599829:A \
--genome_file ../../Genomes/Trrub.GCA_000151425.1_ASM15142v1_genomic.fa

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


