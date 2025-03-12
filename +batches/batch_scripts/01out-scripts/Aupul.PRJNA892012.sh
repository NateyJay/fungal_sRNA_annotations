#!/bin/bash

mkdir ../annotations/Aupul.PRJNA892012
cd ../annotations/Aupul.PRJNA892012

echo Aupul.PRJNA892012


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR21969908 SRR21969907 SRR21969906 \
--conditions SRR21969908:A SRR21969907:A SRR21969906:A \
--genome_file ../../Genomes/Aupul.GCA_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fa

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


