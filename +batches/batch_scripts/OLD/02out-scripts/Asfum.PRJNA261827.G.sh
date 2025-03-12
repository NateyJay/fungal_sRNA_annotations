#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Asfum.PRJNA261827.G.bam
rm /scratch/njohnson/Asfum.PRJNA261827.G.bam



