#!/bin/bash

mkdir ../annotations/Necra.PRJNA350329
cd ../annotations/Necra.PRJNA350329

echo Necra.PRJNA350329


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR4448064 \
--conditions SRR4448064:A \
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


