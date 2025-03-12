#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Plost.PRJNA448380.D.bam
rm /scratch/njohnson/Plost.PRJNA448380.D.bam



