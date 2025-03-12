#!/bin/bash

mkdir ../annotations/Necra.PRJNA196947
cd ../annotations/Necra.PRJNA196947

echo Necra.PRJNA196947


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1657926 SRR826686 SRR826685 SRR826684 \
--conditions SRR1657926:A SRR826686:B SRR826685:C SRR826684:D \
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


