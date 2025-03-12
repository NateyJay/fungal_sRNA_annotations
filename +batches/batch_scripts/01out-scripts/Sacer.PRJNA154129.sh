#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154129
cd ../annotations/Sacer.PRJNA154129

echo Sacer.PRJNA154129


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR332256 SRR332256 \
--conditions SRR332256:A SRR332256:A \
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


