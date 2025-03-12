#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259172
cd ../annotations/Scpom.PRJNA259172

echo Scpom.PRJNA259172


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1555771 SRR1555771 SRR1555769 SRR1555769 SRR1555770 SRR1555770 SRR1555768 SRR1555768 SRR1555766 SRR1555766 \
--conditions SRR1555771:B SRR1555771:B SRR1555769:C SRR1555769:C SRR1555770:D SRR1555770:D SRR1555768:D SRR1555768:D SRR1555766:E SRR1555766:E \
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


