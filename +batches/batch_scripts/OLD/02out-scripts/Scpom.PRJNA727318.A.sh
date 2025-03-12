#!/bin/bash

mkdir ../annotations/Scpom.PRJNA727318
cd ../annotations/Scpom.PRJNA727318

echo Scpom.PRJNA727318.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA727318.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA727318.A.bam
rm /scratch/njohnson/Scpom.PRJNA727318.A.bam



