#!/bin/bash

mkdir ../annotations/Scjap.PRJNA770349
cd ../annotations/Scjap.PRJNA770349

echo Scjap.PRJNA770349


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR16291984 SRR16291985 SRR16291982 SRR16291983 \
--conditions SRR16291984:A SRR16291985:A SRR16291982:Z.d1 SRR16291983:Z.d1 \
--genome_file ../../Genomes/Scjap.GCA_000149845.2_SJ5_genomic.fa

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


