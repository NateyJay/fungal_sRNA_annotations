#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA926984.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asfum.PRJNA926984.B.bam
rm /scratch/njohnson/Asfum.PRJNA926984.B.bam



