#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR643882 SRR643881 SRR643879 SRR643878 SRR643877 SRR643876 SRR643875 \
--conditions SRR643882:A SRR643881:B SRR643879:C SRR643878:D SRR643877:E SRR643876:F SRR643875:G \
--genome_file ../../Genomes/Maory.GCF_000002495.2_MG8_genomic.fa

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


