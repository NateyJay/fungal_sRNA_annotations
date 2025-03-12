#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1583954 SRR1583953 SRR1583952 \
--conditions SRR1583954:A SRR1583953:B SRR1583952:C \
--genome_file ../../Genomes/Asfum.GCF_000002655.1_ASM265v1_genomic.fa

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


