#!/bin/bash

mkdir ../annotations/Capar.PRJNA715092
cd ../annotations/Capar.PRJNA715092

echo Capar.PRJNA715092


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR13986631 SRR13986632 SRR13986633 SRR13986638 SRR13986639 SRR13986640 SRR13986647 SRR13986649 SRR13986650 SRR13986654 SRR13986655 SRR13986656 \
--conditions SRR13986631:D SRR13986632:D SRR13986633:D SRR13986638:C SRR13986639:C SRR13986640:C SRR13986647:F SRR13986649:F SRR13986650:F SRR13986654:E SRR13986655:E SRR13986656:E \
--genome_file ../../Genomes/Capar.GCA_000182765.2_ASM18276v2_genomic.fa

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


