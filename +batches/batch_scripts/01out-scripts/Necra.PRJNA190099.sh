#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR769610 SRR769748 SRR756354 SRR756251 SRR755946 SRR751454 \
--conditions SRR769610:A SRR769748:B SRR756354:C SRR756251:D SRR755946:E SRR751454:F \
--genome_file ../../Genomes/Necra.GCF_000182925.2_NC12_genomic.fa

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


