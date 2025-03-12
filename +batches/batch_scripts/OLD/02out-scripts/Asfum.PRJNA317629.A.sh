#!/bin/bash

mkdir ../annotations/Asfum.PRJNA317629
cd ../annotations/Asfum.PRJNA317629

echo Asfum.PRJNA317629.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA317629.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfum.PRJNA317629.A.bam
rm /scratch/njohnson/Asfum.PRJNA317629.A.bam



