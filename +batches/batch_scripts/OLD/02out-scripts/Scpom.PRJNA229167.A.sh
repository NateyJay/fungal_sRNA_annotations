#!/bin/bash

mkdir ../annotations/Scpom.PRJNA229167
cd ../annotations/Scpom.PRJNA229167

echo Scpom.PRJNA229167.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA229167.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA229167.A.bam
rm /scratch/njohnson/Scpom.PRJNA229167.A.bam



