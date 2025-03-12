#!/bin/bash

mkdir ../annotations/Crneo.PRJNA526042
cd ../annotations/Crneo.PRJNA526042

echo Crneo.PRJNA526042.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Crneo.PRJNA526042.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Crneo.PRJNA526042.A.bam
rm /scratch/njohnson/Crneo.PRJNA526042.A.bam



