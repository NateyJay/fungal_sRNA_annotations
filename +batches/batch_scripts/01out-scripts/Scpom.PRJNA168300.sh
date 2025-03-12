#!/bin/bash

mkdir ../annotations/Scpom.PRJNA168300
cd ../annotations/Scpom.PRJNA168300

echo Scpom.PRJNA168300


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR507114 SRR507113 SRR507112 SRR507110 \
--conditions SRR507114:Z.d1 SRR507113:Z.d1 SRR507112:Z.d1 SRR507110:A \
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


