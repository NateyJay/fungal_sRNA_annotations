#!/bin/bash

mkdir ../annotations/Yalip.PRJNA964764
cd ../annotations/Yalip.PRJNA964764

echo Yalip.PRJNA964764


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR24386479 SRR24386478 SRR24386477 SRR24386483 SRR24386485 SRR24386484 \
--conditions SRR24386479:A SRR24386478:A SRR24386477:A SRR24386483:B SRR24386485:B SRR24386484:B \
--genome_file ../../Genomes/Yalip.GCA_000002525.1_ASM252v1_genomic.fa

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


