#!/bin/bash

mkdir ../annotations/Scscl.PRJNA659617
cd ../annotations/Scscl.PRJNA659617

echo Scscl.PRJNA659617.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA659617.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scscl.PRJNA659617.B.bam
rm /scratch/njohnson/Scscl.PRJNA659617.B.bam



