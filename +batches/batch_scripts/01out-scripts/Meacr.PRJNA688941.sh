#!/bin/bash

mkdir ../annotations/Meacr.PRJNA688941
cd ../annotations/Meacr.PRJNA688941

echo Meacr.PRJNA688941


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR13347136 SRR13347133 SRR13347135 SRR13347134 SRR13347131 SRR13347132 \
--conditions SRR13347136:A SRR13347133:A SRR13347135:A SRR13347134:B SRR13347131:B SRR13347132:B \
--genome_file ../../Genomes/Meacr.GCA_000187405.1_MetAcr_May2010_genomic.fa

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


