#!/bin/bash

mkdir ../annotations/Nobom.PRJNA760284
cd ../annotations/Nobom.PRJNA760284

echo Nobom.PRJNA760284


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR15711005 \
--conditions SRR15711005:A \
--genome_file ../../Genomes/Nobom.GCA_000383075.1_NosBomCQ1_v1.0_genomic.fa

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


