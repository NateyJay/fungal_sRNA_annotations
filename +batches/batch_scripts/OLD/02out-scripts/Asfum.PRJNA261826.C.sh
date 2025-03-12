#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261826.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Asfum.PRJNA261826.C.bam
rm /scratch/njohnson/Asfum.PRJNA261826.C.bam



