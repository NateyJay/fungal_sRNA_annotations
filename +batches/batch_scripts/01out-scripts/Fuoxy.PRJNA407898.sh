#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA407898
cd ../annotations/Fuoxy.PRJNA407898

echo Fuoxy.PRJNA407898


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6052682 SRR6052683 \
--conditions SRR6052682:A SRR6052683:A \
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


