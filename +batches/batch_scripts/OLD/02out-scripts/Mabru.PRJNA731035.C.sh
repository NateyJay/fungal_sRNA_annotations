#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mabru.PRJNA731035.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Mabru.PRJNA731035.C.bam
rm /scratch/njohnson/Mabru.PRJNA731035.C.bam



