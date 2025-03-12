#!/bin/bash

mkdir ../annotations/Nocer.PRJNA408312
cd ../annotations/Nocer.PRJNA408312

echo Nocer.PRJNA408312


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6059173 SRR6059172 SRR6059166 SRR6059167 SRR6059171 SRR6059164 \
--conditions SRR6059173:A SRR6059172:A SRR6059166:A SRR6059167:B SRR6059171:B SRR6059164:B \
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


