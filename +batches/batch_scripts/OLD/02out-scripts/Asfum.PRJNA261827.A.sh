#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfum.PRJNA261827.A.bam
rm /scratch/njohnson/Asfum.PRJNA261827.A.bam



