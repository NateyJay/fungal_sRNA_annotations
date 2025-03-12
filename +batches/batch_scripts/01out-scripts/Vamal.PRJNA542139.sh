#!/bin/bash

mkdir ../annotations/Vamal.PRJNA542139
cd ../annotations/Vamal.PRJNA542139

echo Vamal.PRJNA542139


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9103190 SRR9035426 \
--conditions SRR9103190:A SRR9035426:B \
--genome_file ../../Genomes/Vamal.GCA_025426655.1_ASM2542665v1_genomic.fa

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


