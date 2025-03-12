#!/bin/bash

mkdir ../annotations/Bocin.PRJNA342517
cd ../annotations/Bocin.PRJNA342517

echo Bocin.PRJNA342517


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR4235297 SRR4235298 \
--conditions SRR4235297:A SRR4235298:Z.d1d2 \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


