#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Asfum.PRJNA261827.C.bam
rm /scratch/njohnson/Asfum.PRJNA261827.C.bam



