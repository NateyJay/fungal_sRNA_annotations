#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Asfum.PRJNA261827.E.bam
rm /scratch/njohnson/Asfum.PRJNA261827.E.bam



