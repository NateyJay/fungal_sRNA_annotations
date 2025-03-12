#!/bin/bash

mkdir ../annotations/Venon.PRJNA624041
cd ../annotations/Venon.PRJNA624041

echo Venon.PRJNA624041


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR11514758 SRR11514754 SRR11514755 SRR11514759 SRR11514756 SRR11514760 SRR11514757 SRR11514761 \
--conditions SRR11514758:A SRR11514754:A SRR11514755:A SRR11514759:A SRR11514756:A SRR11514760:A SRR11514757:A SRR11514761:A \
--genome_file ../../Genomes/Venon.GCA_003724135.2_ASM372413v2_genomic.fa

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


