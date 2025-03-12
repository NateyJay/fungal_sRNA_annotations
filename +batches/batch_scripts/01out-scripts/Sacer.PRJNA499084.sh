#!/bin/bash

mkdir ../annotations/Sacer.PRJNA499084
cd ../annotations/Sacer.PRJNA499084

echo Sacer.PRJNA499084


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8130772 SRR8130771 SRR8130770 \
--conditions SRR8130772:A SRR8130771:A SRR8130770:A \
--genome_file ../../Genomes/Sacer.GCA_000146045.2_R64_genomic.fa

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


