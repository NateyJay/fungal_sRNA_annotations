#!/bin/bash

mkdir ../annotations/Scpom.PRJNA144481
cd ../annotations/Scpom.PRJNA144481

echo Scpom.PRJNA144481.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA144481.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA144481.A.bam
rm /scratch/njohnson/Scpom.PRJNA144481.A.bam



