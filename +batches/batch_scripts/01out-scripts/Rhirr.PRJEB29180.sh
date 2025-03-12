#!/bin/bash

mkdir ../annotations/Rhirr.PRJEB29180
cd ../annotations/Rhirr.PRJEB29180

echo Rhirr.PRJEB29180


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs ERR2841782 ERR2841783 ERR2841784 ERR2841786 ERR2841787 ERR2841785 \
--conditions ERR2841782:A ERR2841783:A ERR2841784:A ERR2841786:B ERR2841787:B ERR2841785:B \
--genome_file ../../Genomes/Rhirr.GCF_000439145.1_ASM43914v3_genomic.fa

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


