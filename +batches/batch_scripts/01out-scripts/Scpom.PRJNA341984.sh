#!/bin/bash

mkdir ../annotations/Scpom.PRJNA341984
cd ../annotations/Scpom.PRJNA341984

echo Scpom.PRJNA341984


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR4190396 SRR4190385 SRR4190351 SRR4190352 SRR4190397 SRR4190363 \
--conditions SRR4190396:A SRR4190385:A SRR4190351:D SRR4190352:D SRR4190397:Z.d1 SRR4190363:Z.d1 \
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


