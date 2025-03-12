#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA723916
cd ../annotations/Fuoxy.PRJNA723916

echo Fuoxy.PRJNA723916


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14311542 SRR14311540 SRR14311543 SRR14311541 \
--conditions SRR14311542:A SRR14311540:A SRR14311543:B SRR14311541:B \
--genome_file ../../Genomes/Fuoxy.GCA_013085055.1_ASM1308505v1_genomic.fa

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


