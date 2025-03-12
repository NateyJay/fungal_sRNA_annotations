#!/bin/bash

mkdir ../annotations/Petra.PRJNA756805
cd ../annotations/Petra.PRJNA756805

echo Petra.PRJNA756805


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR15607207 SRR15607208 SRR15607209 \
--conditions SRR15607207:A SRR15607208:A SRR15607209:A \
--genome_file ../../Genomes/Petra.GCA_000516985.1_PFICI_genomic.fa

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


