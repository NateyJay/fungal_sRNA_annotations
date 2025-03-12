#!/bin/bash

mkdir ../annotations/Zytri.PRJNA271281
cd ../annotations/Zytri.PRJNA271281

echo Zytri.PRJNA271281


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR1738220 SRR1738218 \
--conditions SRR1738220:A SRR1738218:B \
--genome_file ../../Genomes/Zytri.GCA_000219625.1_MYCGR_v2.0_genomic.fa

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


