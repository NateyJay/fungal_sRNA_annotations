#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5450818 SRR5450817 SRR5450816 \
--conditions SRR5450818:A SRR5450817:B SRR5450816:C \
--genome_file ../../Genomes/Boell.GCA_024478385.1_BOTELL_9401_1_genomic.fa

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


