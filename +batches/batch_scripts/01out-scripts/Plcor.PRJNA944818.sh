#!/bin/bash

mkdir ../annotations/Plcor.PRJNA944818
cd ../annotations/Plcor.PRJNA944818

echo Plcor.PRJNA944818


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR23874486 SRR23874487 SRR23874485 SRR23874488 SRR23874489 SRR23874490 SRR23874493 SRR23874491 SRR23874492 \
--conditions SRR23874486:A SRR23874487:A SRR23874485:A SRR23874488:B SRR23874489:B SRR23874490:B SRR23874493:C SRR23874491:C SRR23874492:C \
--genome_file ../../Genomes/Plcor.GCA_019677325.2_ASM1967732v2_genomic.fa

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


