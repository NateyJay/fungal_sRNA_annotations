#!/bin/bash

mkdir ../annotations/Tacam.PRJNA268267
cd ../annotations/Tacam.PRJNA268267

echo Tacam.PRJNA268267


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1662192 SRR1662191 \
--conditions SRR1662192:A SRR1662191:B \
--genome_file ../../Genomes/Tacam.GCA_003999685.1_ASM399968v1_genomic.fa

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


