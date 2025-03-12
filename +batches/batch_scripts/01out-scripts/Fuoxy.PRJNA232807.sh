#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA232807
cd ../annotations/Fuoxy.PRJNA232807

echo Fuoxy.PRJNA232807


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1068199 \
--conditions SRR1068199:A \
--genome_file ../../Genomes/Fuoxy.GCA_013085055.1_ASM1308505v1_genomic.fa

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


