#!/bin/bash

mkdir ../annotations/Hicap.PRJNA514312
cd ../annotations/Hicap.PRJNA514312

echo Hicap.PRJNA514312


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8428949 SRR8428948 SRR8428944 SRR8428943 \
--conditions SRR8428949:A SRR8428948:A SRR8428944:B SRR8428943:B \
--genome_file ../../Genomes/Hicap.GCA_000150115.1_ASM15011v1_genomic.fa

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


