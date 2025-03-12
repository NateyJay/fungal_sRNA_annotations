#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA329032
cd ../annotations/Fuoxy.PRJNA329032

echo Fuoxy.PRJNA329032


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR3921571 SRR3921570 \
--conditions SRR3921571:A SRR3921570:B \
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


