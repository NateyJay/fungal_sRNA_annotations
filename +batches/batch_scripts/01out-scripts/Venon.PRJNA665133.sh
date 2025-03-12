#!/bin/bash

mkdir ../annotations/Venon.PRJNA665133
cd ../annotations/Venon.PRJNA665133

echo Venon.PRJNA665133


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR12696055 SRR12696056 SRR12696047 SRR12696051 SRR12696052 SRR12696053 \
--conditions SRR12696055:A SRR12696056:A SRR12696047:A SRR12696051:B SRR12696052:B SRR12696053:B \
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


