#!/bin/bash

mkdir ../annotations/Scscl.PRJNA361523
cd ../annotations/Scscl.PRJNA361523

echo Scscl.PRJNA361523.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA361523.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA361523.A.bam
rm /scratch/njohnson/Scscl.PRJNA361523.A.bam



