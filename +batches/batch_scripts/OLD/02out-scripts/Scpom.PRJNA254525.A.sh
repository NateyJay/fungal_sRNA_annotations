#!/bin/bash

mkdir ../annotations/Scpom.PRJNA254525
cd ../annotations/Scpom.PRJNA254525

echo Scpom.PRJNA254525.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA254525.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA254525.A.bam
rm /scratch/njohnson/Scpom.PRJNA254525.A.bam



