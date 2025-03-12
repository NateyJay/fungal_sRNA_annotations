#!/bin/bash

mkdir ../annotations/Scpom.PRJNA278408
cd ../annotations/Scpom.PRJNA278408

echo Scpom.PRJNA278408.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA278408.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA278408.A.bam
rm /scratch/njohnson/Scpom.PRJNA278408.A.bam



