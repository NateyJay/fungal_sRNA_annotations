#!/bin/bash

mkdir ../annotations/Scpom.PRJNA382810
cd ../annotations/Scpom.PRJNA382810

echo Scpom.PRJNA382810.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA382810.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA382810.A.bam
rm /scratch/njohnson/Scpom.PRJNA382810.A.bam



