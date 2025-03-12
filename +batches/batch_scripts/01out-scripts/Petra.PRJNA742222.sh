#!/bin/bash

mkdir ../annotations/Petra.PRJNA742222
cd ../annotations/Petra.PRJNA742222

echo Petra.PRJNA742222


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR14996693 SRR14996695 SRR14996694 \
--conditions SRR14996693:A SRR14996695:A SRR14996694:A \
--genome_file ../../Genomes/Petra.GCA_000516985.1_PFICI_genomic.fa

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


