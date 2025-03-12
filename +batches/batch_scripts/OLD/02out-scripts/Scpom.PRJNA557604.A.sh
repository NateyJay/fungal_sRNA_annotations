#!/bin/bash

mkdir ../annotations/Scpom.PRJNA557604
cd ../annotations/Scpom.PRJNA557604

echo Scpom.PRJNA557604.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA557604.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA557604.A.bam
rm /scratch/njohnson/Scpom.PRJNA557604.A.bam



