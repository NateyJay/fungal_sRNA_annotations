#!/bin/bash

mkdir ../annotations/Scpom.PRJNA122193
cd ../annotations/Scpom.PRJNA122193

echo Scpom.PRJNA122193.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA122193.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA122193.A.bam
rm /scratch/njohnson/Scpom.PRJNA122193.A.bam



