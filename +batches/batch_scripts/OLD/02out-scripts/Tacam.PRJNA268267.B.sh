#!/bin/bash

mkdir ../annotations/Tacam.PRJNA268267
cd ../annotations/Tacam.PRJNA268267

echo Tacam.PRJNA268267.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tacam.PRJNA268267.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Tacam.PRJNA268267.B.bam
rm /scratch/njohnson/Tacam.PRJNA268267.B.bam



