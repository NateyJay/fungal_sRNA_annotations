#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Asfum.PRJNA261827.B.bam
rm /scratch/njohnson/Asfum.PRJNA261827.B.bam



