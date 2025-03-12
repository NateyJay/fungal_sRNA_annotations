#!/bin/bash

mkdir ../annotations/Labic.PRJNA481323
cd ../annotations/Labic.PRJNA481323

echo Labic.PRJNA481323


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7525707 SRR7525706 SRR7525705 SRR7525697 SRR7525698 SRR7525696 \
--conditions SRR7525707:A SRR7525706:A SRR7525705:A SRR7525697:B SRR7525698:B SRR7525696:B \
--genome_file ../../Genomes/Labic.GCA_000143565.1_V1.0_genomic.fa

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


