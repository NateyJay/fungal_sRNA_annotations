#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8374850 SRR8374847 SRR8374848 SRR8374849 \
--conditions SRR8374850:A SRR8374847:B SRR8374848:C SRR8374849:D \
--genome_file ../../Genomes/Bodot.GCA_011503125.2_ASM1150312v2_genomic.fa

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


