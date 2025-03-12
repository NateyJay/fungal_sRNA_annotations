#!/bin/bash

mkdir ../annotations/Fugra.PRJNA683746
cd ../annotations/Fugra.PRJNA683746

echo Fugra.PRJNA683746


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR13222421 SRR13222412 SRR13222420 SRR13222416 SRR13222417 SRR13222418 \
--conditions SRR13222421:A SRR13222412:A SRR13222420:A SRR13222416:B SRR13222417:B SRR13222418:B \
--genome_file ../../Genomes/Fugra.GCF_000240135.3_ASM24013v3_genomic.fa

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


