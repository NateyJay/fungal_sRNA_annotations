#!/bin/bash

mkdir ../annotations/Plost.PRJNA448380
cd ../annotations/Plost.PRJNA448380

echo Plost.PRJNA448380.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plost.PRJNA448380.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Plost.PRJNA448380.F.bam
rm /scratch/njohnson/Plost.PRJNA448380.F.bam



