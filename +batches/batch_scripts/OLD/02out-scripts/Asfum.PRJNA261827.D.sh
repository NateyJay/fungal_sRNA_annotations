#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Asfum.PRJNA261827.D.bam
rm /scratch/njohnson/Asfum.PRJNA261827.D.bam



