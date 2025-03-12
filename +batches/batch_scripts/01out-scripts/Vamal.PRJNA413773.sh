#!/bin/bash

mkdir ../annotations/Vamal.PRJNA413773
cd ../annotations/Vamal.PRJNA413773

echo Vamal.PRJNA413773


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6153307 SRR6153308 \
--conditions SRR6153307:A SRR6153308:A \
--genome_file ../../Genomes/Vamal.GCA_025426655.1_ASM2542665v1_genomic.fa

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


