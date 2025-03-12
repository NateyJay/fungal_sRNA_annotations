#!/bin/bash

mkdir ../annotations/Asfla.PRJNA438019
cd ../annotations/Asfla.PRJNA438019

echo Asfla.PRJNA438019


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6828228 SRR6828236 SRR6828243 SRR6828241 \
--conditions SRR6828228:A SRR6828236:A SRR6828243:B SRR6828241:B \
--genome_file ../../Genomes/Asfla.GCA_014117465.1_ASM1411746v1_genomic.fa

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


