#!/bin/bash

mkdir ../annotations/Bebas.PRJNA647702
cd ../annotations/Bebas.PRJNA647702

echo Bebas.PRJNA647702


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR12284227 SRR12284226 SRR12284230 SRR12284229 SRR12284228 \
--conditions SRR12284227:A SRR12284226:A SRR12284230:B SRR12284229:B SRR12284228:B \
--genome_file ../../Genomes/Bebas.GCA_000280675.1_ASM28067v1_genomic.fa

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


