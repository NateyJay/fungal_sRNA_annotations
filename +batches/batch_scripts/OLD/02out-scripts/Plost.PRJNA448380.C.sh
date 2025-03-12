#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Plost.PRJNA448380.C.bam
rm /scratch/njohnson/Plost.PRJNA448380.C.bam



