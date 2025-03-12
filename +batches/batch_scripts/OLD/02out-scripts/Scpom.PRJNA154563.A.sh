#!/bin/bash

mkdir ../annotations/Scpom.PRJNA154563
cd ../annotations/Scpom.PRJNA154563

echo Scpom.PRJNA154563.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA154563.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA154563.A.bam
rm /scratch/njohnson/Scpom.PRJNA154563.A.bam



