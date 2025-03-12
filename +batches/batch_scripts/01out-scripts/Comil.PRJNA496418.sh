#!/bin/bash

mkdir ../annotations/Comil.PRJNA496418
cd ../annotations/Comil.PRJNA496418

echo Comil.PRJNA496418


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR8054055 SRR8054060 SRR8054056 SRR8054057 SRR8054058 SRR8054059 \
--conditions SRR8054055:A SRR8054060:A SRR8054056:A SRR8054057:B SRR8054058:B SRR8054059:B \
--genome_file ../../Genomes/Comil.GCA_000225605.1_CmilitarisCM01_v01_genomic.fa

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


