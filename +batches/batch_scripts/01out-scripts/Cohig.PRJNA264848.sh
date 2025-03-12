#!/bin/bash

mkdir ../annotations/Cohig.PRJNA264848
cd ../annotations/Cohig.PRJNA264848

echo Cohig.PRJNA264848


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1630053 SRR1630052 SRR1630051 SRR1630050 SRR1630049 SRR1630048 SRR1630047 SRR1630046 SRR1630045 SRR1630044 SRR1630043 SRR1630042 SRR1630071 SRR1630069 SRR1630070 SRR1630068 SRR1630067 SRR1630066 \
--conditions SRR1630053:Z.d1d2 SRR1630052:Z.d1d2 SRR1630051:Z.d1d2 SRR1630050:Z.d1d2 SRR1630049:Y.d2 SRR1630048:Y.d2 SRR1630047:Y.d2 SRR1630046:Y.d2 SRR1630045:X.d1 SRR1630044:X.d1 SRR1630043:X.d1 SRR1630042:X.d1 SRR1630071:A SRR1630069:A SRR1630070:A SRR1630068:B SRR1630067:B SRR1630066:B \
--genome_file ../../Genomes/Cohig.GCA_001672515.1_ASM167251v1_genomic.fa

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


