#!/bin/bash

mkdir ../annotations/Diseg.PRJNA534364
cd ../annotations/Diseg.PRJNA534364

echo Diseg.PRJNA534364


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8948283 SRR8948284 SRR8948281 \
--conditions SRR8948283:A SRR8948284:A SRR8948281:A \
--genome_file ../../Genomes/Diseg.GCA_004522025.1_ASM452202v1_genomic.fa

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


