#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154125
cd ../annotations/Sacer.PRJNA154125

echo Sacer.PRJNA154125


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR332051 SRR332049 \
--conditions SRR332051:Z.d1 SRR332049:A \
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


