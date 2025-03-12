#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530565
cd ../annotations/Nacas.PRJNA530565

echo Nacas.PRJNA530565


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9711187 SRR9711188 SRR9711192 SRR9711191 \
--conditions SRR9711187:A SRR9711188:A SRR9711192:Z.d1 SRR9711191:Z.d1 \
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


