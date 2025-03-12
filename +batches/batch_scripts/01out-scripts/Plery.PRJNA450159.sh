#!/bin/bash

mkdir ../annotations/Plery.PRJNA450159
cd ../annotations/Plery.PRJNA450159

echo Plery.PRJNA450159


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7003643 \
--conditions SRR7003643:A \
--genome_file ../../Genomes/Plery.GCA_029467805.1_ASM2946780v1_genomic.fa

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


