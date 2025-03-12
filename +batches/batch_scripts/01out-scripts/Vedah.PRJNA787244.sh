#!/bin/bash

mkdir ../annotations/Vedah.PRJNA787244
cd ../annotations/Vedah.PRJNA787244

echo Vedah.PRJNA787244


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR17168772 SRR17168773 \
--conditions SRR17168772:A SRR17168773:A \
--genome_file ../../Genomes/Vedah.GCA_000150675.2_ASM15067v2_genomic.fa

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


