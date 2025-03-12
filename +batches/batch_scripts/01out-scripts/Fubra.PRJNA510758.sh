#!/bin/bash

mkdir ../annotations/Fubra.PRJNA510758
cd ../annotations/Fubra.PRJNA510758

echo Fubra.PRJNA510758


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8362135 SRR8362142 SRR8362136 SRR8362137 SRR8362133 SRR8362138 SRR8362145 SRR8362134 SRR8362146 \
--conditions SRR8362135:A SRR8362142:A SRR8362136:A SRR8362137:B SRR8362133:B SRR8362138:B SRR8362145:C SRR8362134:C SRR8362146:C \
--genome_file ../../Genomes/Fubra.GCA_018886245.1_Fb-HN-1_genomic.fa

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


