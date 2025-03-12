#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193535
cd ../annotations/Bocin.PRJNA193535

echo Bocin.PRJNA193535


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR786978 SRR786977 SRR786976 \
--conditions SRR786978:A SRR786977:B SRR786976:C \
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


