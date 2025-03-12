#!/bin/bash

mkdir ../annotations/Scscl.PRJNA140539
cd ../annotations/Scscl.PRJNA140539

echo Scscl.PRJNA140539


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR189065 \
--conditions SRR189065:A \
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


