#!/bin/bash

mkdir ../annotations/Asfum.PRJNA317629
cd ../annotations/Asfum.PRJNA317629

echo Asfum.PRJNA317629.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA317629.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asfum.PRJNA317629.B.bam
rm /scratch/njohnson/Asfum.PRJNA317629.B.bam



