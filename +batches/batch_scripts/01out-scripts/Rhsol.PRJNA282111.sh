#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1994871 SRR1994872 SRR1994873 SRR1994874 SRR1994875 SRR1994876 SRR1994877 \
--conditions SRR1994871:A SRR1994872:B SRR1994873:C SRR1994874:D SRR1994875:E SRR1994876:F SRR1994877:G \
--genome_file ../../Genomes/Rhsol.GCA_016906535.1_ASM1690653v1_genomic.fa

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


