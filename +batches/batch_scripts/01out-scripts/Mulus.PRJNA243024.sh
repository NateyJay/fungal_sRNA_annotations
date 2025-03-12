#!/bin/bash

mkdir ../annotations/Mulus.PRJNA243024
cd ../annotations/Mulus.PRJNA243024

echo Mulus.PRJNA243024


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1209506 SRR1209508 SRR1209509 SRR1209507 SRR1209510 SRR1209511 \
--conditions SRR1209506:A SRR1209508:B SRR1209509:B SRR1209507:B SRR1209510:C SRR1209511:C \
--genome_file ../../Genomes/Mulus.GCA_010203745.1_Muccir1_3_genomic.fa

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


