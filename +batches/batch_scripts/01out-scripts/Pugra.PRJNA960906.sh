#!/bin/bash

mkdir ../annotations/Pugra.PRJNA960906
cd ../annotations/Pugra.PRJNA960906

echo Pugra.PRJNA960906


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR24282674 SRR24282673 SRR24282675 \
--conditions SRR24282674:A SRR24282673:A SRR24282675:A \
--genome_file ../../Genomes/Pugra.GCA_000149925.1_ASM14992v1_genomic.fa

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


