#!/bin/bash

mkdir ../annotations/Bocin.PRJNA431815
cd ../annotations/Bocin.PRJNA431815

echo Bocin.PRJNA431815


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR6667534 SRR6667535 SRR6667533 SRR6667531 SRR6667530 SRR6667532 SRR6667520 SRR6667536 SRR6667537 \
--conditions SRR6667534:A SRR6667535:A SRR6667533:A SRR6667531:B SRR6667530:B SRR6667532:B SRR6667520:C SRR6667536:C SRR6667537:C \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


