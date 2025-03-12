#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.H

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.H.bam
yasma.py tradeoff -o . -n H -ac H -a /scratch/njohnson/Asfum.PRJNA261827.H.bam
rm /scratch/njohnson/Asfum.PRJNA261827.H.bam



