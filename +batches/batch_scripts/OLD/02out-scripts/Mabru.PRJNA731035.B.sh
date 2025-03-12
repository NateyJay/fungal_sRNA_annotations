#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mabru.PRJNA731035.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Mabru.PRJNA731035.B.bam
rm /scratch/njohnson/Mabru.PRJNA731035.B.bam



