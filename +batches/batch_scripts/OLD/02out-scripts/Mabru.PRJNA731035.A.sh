#!/bin/bash

mkdir ../annotations/Mabru.PRJNA731035
cd ../annotations/Mabru.PRJNA731035

echo Mabru.PRJNA731035.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mabru.PRJNA731035.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Mabru.PRJNA731035.A.bam
rm /scratch/njohnson/Mabru.PRJNA731035.A.bam



