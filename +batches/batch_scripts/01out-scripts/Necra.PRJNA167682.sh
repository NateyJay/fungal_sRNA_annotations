#!/bin/bash

mkdir ../annotations/Necra.PRJNA167682
cd ../annotations/Necra.PRJNA167682

echo Necra.PRJNA167682


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR502771 \
--conditions SRR502771:A \
--genome_file ../../Genomes/Necra.GCF_000182925.2_NC12_genomic.fa

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


