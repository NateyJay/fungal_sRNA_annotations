#!/bin/bash

mkdir ../annotations/Blgra.PRJNA142095
cd ../annotations/Blgra.PRJNA142095

echo Blgra.PRJNA142095


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR101428 SRR101430 \
--conditions SRR101428:A SRR101430:B \
--genome_file ../../Genomes/Blgra.GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.fa

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


