#!/bin/bash

mkdir ../annotations/Scscl.PRJNA659617
cd ../annotations/Scscl.PRJNA659617

echo Scscl.PRJNA659617.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA659617.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Scscl.PRJNA659617.C.bam
rm /scratch/njohnson/Scscl.PRJNA659617.C.bam



