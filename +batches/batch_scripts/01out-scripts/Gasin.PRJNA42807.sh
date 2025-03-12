#!/bin/bash

mkdir ../annotations/Gasin.PRJNA42807
cd ../annotations/Gasin.PRJNA42807

echo Gasin.PRJNA42807


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR929280 SRR1562261 \
--conditions SRR929280:A SRR1562261:A \
--genome_file ../../Genomes/Gasin.GCA_002760635.1_GanSi1.6_genomic.fa

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


