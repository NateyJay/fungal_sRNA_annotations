#!/bin/bash

mkdir ../annotations/Scpom.PRJNA125397
cd ../annotations/Scpom.PRJNA125397

echo Scpom.PRJNA125397.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA125397.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA125397.A.bam
rm /scratch/njohnson/Scpom.PRJNA125397.A.bam



