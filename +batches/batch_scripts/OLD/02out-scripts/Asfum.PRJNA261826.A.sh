#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261826.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfum.PRJNA261826.A.bam
rm /scratch/njohnson/Asfum.PRJNA261826.A.bam



