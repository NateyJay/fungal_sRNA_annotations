#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Plost.PRJNA448380.B.bam
rm /scratch/njohnson/Plost.PRJNA448380.B.bam



