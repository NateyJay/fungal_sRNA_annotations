#!/bin/bash

mkdir ../annotations/Crgat.PRJNA368962
cd ../annotations/Crgat.PRJNA368962

echo Crgat.PRJNA368962


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5209175 \
--conditions SRR5209175:A \
--genome_file ../../Genomes/Crgat.GCA_000185945.1_ASM18594v1_genomic.fa

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


