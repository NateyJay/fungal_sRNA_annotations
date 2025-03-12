#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Plost.PRJNA448380.A.bam
rm /scratch/njohnson/Plost.PRJNA448380.A.bam



