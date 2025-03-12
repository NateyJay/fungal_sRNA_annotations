#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR23205001 SRR23205002 SRR23205000 SRR23204997 SRR23204998 SRR23204999 SRR23204996 SRR23204994 SRR23204995 \
--conditions SRR23205001:A SRR23205002:A SRR23205000:A SRR23204997:B SRR23204998:B SRR23204999:B SRR23204996:C SRR23204994:C SRR23204995:C \
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


