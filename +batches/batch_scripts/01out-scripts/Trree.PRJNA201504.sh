#!/bin/bash

mkdir ../annotations/Trree.PRJNA201504
cd ../annotations/Trree.PRJNA201504

echo Trree.PRJNA201504


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR847118 SRR847119 \
--conditions SRR847118:A SRR847119:B \
--genome_file ../../Genomes/Trree.GCA_000167675.2_v2.0_genomic.fa

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


