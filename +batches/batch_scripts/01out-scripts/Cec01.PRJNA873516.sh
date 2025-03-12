#!/bin/bash

mkdir ../annotations/Cec01.PRJNA873516
cd ../annotations/Cec01.PRJNA873516

echo Cec01.PRJNA873516


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR21284932 SRR21285828 SRR21284931 SRR21284929 SRR21284928 SRR21284930 \
--conditions SRR21284932:A SRR21285828:A SRR21284931:A SRR21284929:B SRR21284928:B SRR21284930:B \
--genome_file ../../Genomes/Cec01.GCA_025200755.1_ASM2520075v1_genomic.fa

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


