#!/bin/bash

mkdir ../annotations/Bocin.PRJNA1092616
cd ../annotations/Bocin.PRJNA1092616

echo Bocin.PRJNA1092616


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR28472517 SRR28472519 SRR28472518 \
--conditions SRR28472517:A SRR28472519:A SRR28472518:A \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


