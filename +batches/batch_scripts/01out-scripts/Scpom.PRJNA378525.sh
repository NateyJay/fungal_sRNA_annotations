#!/bin/bash

mkdir ../annotations/Scpom.PRJNA378525
cd ../annotations/Scpom.PRJNA378525

echo Scpom.PRJNA378525


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5320763 SRR5320764 \
--conditions SRR5320763:A SRR5320764:A \
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


