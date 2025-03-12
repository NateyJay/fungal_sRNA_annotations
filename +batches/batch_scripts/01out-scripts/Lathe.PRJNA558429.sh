#!/bin/bash

mkdir ../annotations/Lathe.PRJNA558429
cd ../annotations/Lathe.PRJNA558429

echo Lathe.PRJNA558429


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR9903554 SRR9903553 SRR9903556 SRR12538912 SRR12538913 SRR12538914 \
--conditions SRR9903554:A SRR9903553:A SRR9903556:A SRR12538912:B SRR12538913:B SRR12538914:B \
--genome_file ../../Genomes/Lathe.GCA_012971845.1_ASM1297184v1_genomic.fa

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


