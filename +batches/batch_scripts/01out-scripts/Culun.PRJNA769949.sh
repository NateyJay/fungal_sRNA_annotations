#!/bin/bash

mkdir ../annotations/Culun.PRJNA769949
cd ../annotations/Culun.PRJNA769949

echo Culun.PRJNA769949


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR16277948 SRR16277950 \
--conditions SRR16277948:A SRR16277950:B \
--genome_file ../../Genomes/Culun.GCA_005212705.1_ASM521270v1_genomic.fa

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


