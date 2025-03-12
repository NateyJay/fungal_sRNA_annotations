#!/bin/bash

mkdir ../annotations/Scscl.PRJNA361523
cd ../annotations/Scscl.PRJNA361523

echo Scscl.PRJNA361523.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA361523.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scscl.PRJNA361523.B.bam
rm /scratch/njohnson/Scscl.PRJNA361523.B.bam



