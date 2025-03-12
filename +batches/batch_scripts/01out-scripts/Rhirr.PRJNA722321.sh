#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14251176 SRR14251177 SRR14251175 SRR14251174 SRR14251179 SRR14251181 SRR14251180 SRR14251178 SRR14251182 SRR14251183 SRR14251184 SRR14251185 SRR14251187 SRR14251186 \
--conditions SRR14251176:A SRR14251177:A SRR14251175:A SRR14251174:A SRR14251179:B SRR14251181:B SRR14251180:B SRR14251178:B SRR14251182:C SRR14251183:C SRR14251184:C SRR14251185:D SRR14251187:D SRR14251186:D \
--genome_file ../../Genomes/Rhirr.GCF_000439145.1_ASM43914v3_genomic.fa

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


