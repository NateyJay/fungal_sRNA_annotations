#!/bin/bash

mkdir ../annotations/Scscl.PRJNA379694
cd ../annotations/Scscl.PRJNA379694

echo Scscl.PRJNA379694


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8306349 SRR8306350 \
--conditions SRR8306349:A SRR8306350:A \
--genome_file ../../Genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.fa

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


