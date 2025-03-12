#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA760453
cd ../annotations/Fuoxy.PRJNA760453

echo Fuoxy.PRJNA760453


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR15712226 SRR15712225 SRR15712227 SRR15712232 SRR15712233 SRR15712234 \
--conditions SRR15712226:B SRR15712225:B SRR15712227:B SRR15712232:C SRR15712233:C SRR15712234:C \
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


