#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Asfum.PRJNA261827.F.bam
rm /scratch/njohnson/Asfum.PRJNA261827.F.bam



