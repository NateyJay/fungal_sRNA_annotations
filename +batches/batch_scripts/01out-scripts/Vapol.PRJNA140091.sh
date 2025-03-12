#!/bin/bash

mkdir ../annotations/Vapol.PRJNA140091
cd ../annotations/Vapol.PRJNA140091

echo Vapol.PRJNA140091


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR202951 \
--conditions SRR202951:A \
--genome_file ../../Genomes/Vapol.GCA_000150035.1_ASM15003v1_genomic.fa

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


