#!/bin/bash

mkdir ../annotations/Scscl.PRJNA315516
cd ../annotations/Scscl.PRJNA315516

echo Scscl.PRJNA315516


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3383805 SRR3383815 SRR3383816 \
--conditions SRR3383805:A SRR3383815:A SRR3383816:A \
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


