#!/bin/bash

mkdir ../annotations/Trasp.PRJNA638238
cd ../annotations/Trasp.PRJNA638238

echo Trasp.PRJNA638238


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR11961845 \
--conditions SRR11961845:A \
--genome_file ../../Genomes/Trasp.GCA_003025105.1_Trias_v._1.0_genomic.fa

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


