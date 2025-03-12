#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA562097
cd ../annotations/Fuoxy.PRJNA562097

echo Fuoxy.PRJNA562097


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR10020071 SRR10020072 SRR10020068 SRR10020070 SRR10020069 \
--conditions SRR10020071:Z.q2 SRR10020072:Z.q2 SRR10020068:A SRR10020070:A SRR10020069:A \
--genome_file ../../Genomes/Fuoxy.GCA_013085055.1_ASM1308505v1_genomic.fa

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


