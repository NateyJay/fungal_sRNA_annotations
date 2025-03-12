#!/bin/bash

mkdir ../annotations/Scpom.PRJNA557604
cd ../annotations/Scpom.PRJNA557604

echo Scpom.PRJNA557604


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9866296 \
--conditions SRR9866296:A \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


