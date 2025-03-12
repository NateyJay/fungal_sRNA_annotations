#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA348385.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scscl.PRJNA348385.B.bam
rm /scratch/njohnson/Scscl.PRJNA348385.B.bam



