#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR15361397 SRR15361398 SRR15361399 SRR15361400 SRR15361401 SRR15361402 SRR15361403 SRR15361404 SRR15361405 SRR15361406 SRR15361407 SRR15361408 SRR15361409 SRR15361410 SRR15361411 SRR15361412 \
--conditions SRR15361397:A SRR15361398:B SRR15361399:C SRR15361400:D SRR15361401:E SRR15361402:F SRR15361403:G SRR15361404:H SRR15361405:I SRR15361406:J SRR15361407:K SRR15361408:L SRR15361409:M SRR15361410:N SRR15361411:O SRR15361412:P \
--genome_file ../../Genomes/Bocin.GCF_000143535.2_ASM14353v4_genomic.fa

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


