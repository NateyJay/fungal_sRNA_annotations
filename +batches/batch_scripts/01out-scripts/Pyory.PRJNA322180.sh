#!/bin/bash

mkdir ../annotations/Pyory.PRJNA322180
cd ../annotations/Pyory.PRJNA322180

echo Pyory.PRJNA322180


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3545690 SRR3545705 SRR3545705 SRR3545690 \
--conditions SRR3545690:A SRR3545705:A SRR3545705:A SRR3545690:A \
--genome_file ../../Genomes/Pyory.GCA_000002495.2_MG8_genomic.fa

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


