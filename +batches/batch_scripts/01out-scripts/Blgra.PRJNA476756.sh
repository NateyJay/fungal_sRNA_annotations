#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR7363329 SRR7363330 SRR7363328 SRR7363332 SRR7363333 SRR7363331 SRR7363334 SRR7363336 SRR7363335 SRR7363339 SRR7363337 SRR7363338 SRR7363340 SRR7363341 SRR7363342 \
--conditions SRR7363329:A SRR7363330:A SRR7363328:A SRR7363332:B SRR7363333:B SRR7363331:B SRR7363334:C SRR7363336:C SRR7363335:C SRR7363339:D SRR7363337:D SRR7363338:D SRR7363340:E SRR7363341:E SRR7363342:E \
--genome_file ../../Genomes/Blgra.GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.fa

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


