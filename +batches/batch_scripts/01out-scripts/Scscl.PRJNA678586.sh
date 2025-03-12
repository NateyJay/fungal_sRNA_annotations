#!/bin/bash

mkdir ../annotations/Scscl.PRJNA678586
cd ../annotations/Scscl.PRJNA678586

echo Scscl.PRJNA678586


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR13071041 SRR13071040 SRR13071042 \
--conditions SRR13071041:A SRR13071040:A SRR13071042:A \
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


