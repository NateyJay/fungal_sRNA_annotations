#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA926984.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Asfum.PRJNA926984.C.bam
rm /scratch/njohnson/Asfum.PRJNA926984.C.bam



