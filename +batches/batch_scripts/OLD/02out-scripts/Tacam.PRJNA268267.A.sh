#!/bin/bash

mkdir ../annotations/Tacam.PRJNA268267
cd ../annotations/Tacam.PRJNA268267

echo Tacam.PRJNA268267.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tacam.PRJNA268267.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Tacam.PRJNA268267.A.bam
rm /scratch/njohnson/Tacam.PRJNA268267.A.bam



