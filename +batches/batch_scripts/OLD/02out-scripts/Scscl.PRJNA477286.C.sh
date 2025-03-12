#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA477286.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Scscl.PRJNA477286.C.bam
rm /scratch/njohnson/Scscl.PRJNA477286.C.bam



