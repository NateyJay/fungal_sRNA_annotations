#!/bin/bash

mkdir ../annotations/Blgra.PRJNA479878
cd ../annotations/Blgra.PRJNA479878

echo Blgra.PRJNA479878


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7475546 \
--conditions SRR7475546:A \
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


