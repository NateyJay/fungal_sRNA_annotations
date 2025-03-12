#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA348385.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA348385.A.bam
rm /scratch/njohnson/Scscl.PRJNA348385.A.bam



