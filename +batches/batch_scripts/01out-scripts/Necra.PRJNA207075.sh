#!/bin/bash

mkdir ../annotations/Necra.PRJNA207075
cd ../annotations/Necra.PRJNA207075

echo Necra.PRJNA207075


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR882074 \
--conditions SRR882074:A \
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


