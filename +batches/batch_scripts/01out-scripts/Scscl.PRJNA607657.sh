#!/bin/bash

mkdir ../annotations/Scscl.PRJNA607657
cd ../annotations/Scscl.PRJNA607657

echo Scscl.PRJNA607657


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR11117983 SRR11117991 SRR11117992 \
--conditions SRR11117983:A SRR11117991:A SRR11117992:A \
--genome_file ../../Genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.fa

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


