#!/bin/bash

mkdir ../annotations/Scscl.PRJNA678586
cd ../annotations/Scscl.PRJNA678586

echo Scscl.PRJNA678586.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA678586.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA678586.A.bam
rm /scratch/njohnson/Scscl.PRJNA678586.A.bam



