#!/bin/bash

mkdir ../annotations/Maory.PRJNA326250
cd ../annotations/Maory.PRJNA326250

echo Maory.PRJNA326250


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3703046 \
--conditions SRR3703046:A \
--genome_file ../../Genomes/Maory.GCF_000002495.2_MG8_genomic.fa

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


