#!/bin/bash

mkdir ../annotations/Nocer.PRJNA487111
cd ../annotations/Nocer.PRJNA487111

echo Nocer.PRJNA487111


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7741650 SRR7741652 SRR7741651 SRR7741655 SRR7741649 SRR7741656 \
--conditions SRR7741650:A SRR7741652:A SRR7741651:A SRR7741655:B SRR7741649:B SRR7741656:B \
--genome_file ../../Genomes/Nocer.GCF_000988165.1_ASM98816v1_genomic.fa

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


