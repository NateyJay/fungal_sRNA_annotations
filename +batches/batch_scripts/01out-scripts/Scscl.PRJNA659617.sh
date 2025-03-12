#!/bin/bash

mkdir ../annotations/Scscl.PRJNA659617
cd ../annotations/Scscl.PRJNA659617

echo Scscl.PRJNA659617


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR12527895 SRR12527894 SRR12527896 SRR12527897 SRR12527899 SRR12527898 \
--conditions SRR12527895:A SRR12527894:A SRR12527896:B SRR12527897:B SRR12527899:C SRR12527898:C \
--genome_file ../../Genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.fa

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


