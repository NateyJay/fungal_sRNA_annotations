#!/bin/bash

mkdir ../annotations/Scpom.PRJNA125397
cd ../annotations/Scpom.PRJNA125397

echo Scpom.PRJNA125397


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR035639 SRR035883 SRR035642 SRR035641 SRR035640 \
--conditions SRR035639:A SRR035883:A SRR035642:A SRR035641:A SRR035640:A \
--genome_file ../../Genomes/Scpom.GCA_000002945.2_ASM294v2_genomic.fa

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


