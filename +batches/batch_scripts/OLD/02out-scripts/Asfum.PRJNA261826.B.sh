#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261826.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asfum.PRJNA261826.B.bam
rm /scratch/njohnson/Asfum.PRJNA261826.B.bam



