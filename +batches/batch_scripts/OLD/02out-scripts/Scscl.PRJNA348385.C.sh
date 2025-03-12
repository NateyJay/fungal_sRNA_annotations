#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA348385.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Scscl.PRJNA348385.C.bam
rm /scratch/njohnson/Scscl.PRJNA348385.C.bam



