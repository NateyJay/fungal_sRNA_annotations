#!/bin/bash

mkdir ../annotations/Scpom.PRJNA382810
cd ../annotations/Scpom.PRJNA382810

echo Scpom.PRJNA382810


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR5445684 SRR5445683 SRR5445672 \
--conditions SRR5445684:A SRR5445683:A SRR5445672:A \
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


