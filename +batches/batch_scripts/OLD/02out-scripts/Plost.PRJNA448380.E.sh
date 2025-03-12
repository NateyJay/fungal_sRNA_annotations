#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Plost.PRJNA448380.E.bam
rm /scratch/njohnson/Plost.PRJNA448380.E.bam



