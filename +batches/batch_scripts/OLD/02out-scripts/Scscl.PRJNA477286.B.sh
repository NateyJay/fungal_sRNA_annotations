#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA477286.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scscl.PRJNA477286.B.bam
rm /scratch/njohnson/Scscl.PRJNA477286.B.bam



