#!/bin/bash

mkdir ../annotations/Scpom.PRJNA322452
cd ../annotations/Scpom.PRJNA322452

echo Scpom.PRJNA322452.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA322452.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA322452.A.bam
rm /scratch/njohnson/Scpom.PRJNA322452.A.bam



