#!/bin/bash

mkdir ../annotations/Trrub.PRJNA483837
cd ../annotations/Trrub.PRJNA483837

echo Trrub.PRJNA483837


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7630467 SRR7630468 \
--conditions SRR7630467:A SRR7630468:B \
--genome_file ../../Genomes/Trrub.GCA_000151425.1_ASM15142v1_genomic.fa

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


