#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7550260 SRR7550250 SRR7550251 SRR7550275 SRR7550277 SRR7550276 SRR7550272 SRR7550273 SRR7550274 SRR7550270 SRR7550271 SRR7550279 \
--conditions SRR7550260:A SRR7550250:A SRR7550251:A SRR7550275:B SRR7550277:B SRR7550276:B SRR7550272:C SRR7550273:C SRR7550274:C SRR7550270:D SRR7550271:D SRR7550279:D \
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


