#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR20012924 SRR20012936 SRR20012922 SRR20012932 SRR20012935 SRR20012925 \
--conditions SRR20012924:A SRR20012936:B SRR20012922:C SRR20012932:Z.d1 SRR20012935:Y.d1d2 SRR20012925:X.d2 \
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


