#!/bin/bash

mkdir ../annotations/Scpom.PRJNA254525
cd ../annotations/Scpom.PRJNA254525

echo Scpom.PRJNA254525


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1508480 SRR1508480 \
--conditions SRR1508480:A SRR1508480:A \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


