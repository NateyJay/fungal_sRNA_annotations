#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA472169
cd ../annotations/Fuoxy.PRJNA472169

echo Fuoxy.PRJNA472169


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7187364 SRR7187367 SRR7187371 SRR7187368 SRR7187372 SRR7187365 SRR7187369 SRR7187360 SRR7187373 SRR7187374 SRR7187361 SRR7187362 \
--conditions SRR7187364:A SRR7187367:A SRR7187371:A SRR7187368:B SRR7187372:B SRR7187365:B SRR7187369:C SRR7187360:C SRR7187373:C SRR7187374:D SRR7187361:D SRR7187362:D \
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


