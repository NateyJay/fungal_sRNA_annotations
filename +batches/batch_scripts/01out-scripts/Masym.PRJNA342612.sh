#!/bin/bash

mkdir ../annotations/Masym.PRJNA342612
cd ../annotations/Masym.PRJNA342612

echo Masym.PRJNA342612


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR4237864 SRR4237857 SRR4237858 SRR4237863 SRR4237866 SRR4237862 SRR4237865 SRR4237861 SRR4237859 SRR4237860 \
--conditions SRR4237864:A SRR4237857:A SRR4237858:A SRR4237863:A SRR4237866:A SRR4237862:B SRR4237865:B SRR4237861:B SRR4237859:B SRR4237860:B \
--genome_file ../../Genomes/Masym.GCA_000349305.2_ASM34930v2_genomic.fa

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


