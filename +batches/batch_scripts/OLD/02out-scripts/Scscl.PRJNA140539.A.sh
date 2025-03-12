#!/bin/bash

mkdir ../annotations/Scscl.PRJNA140539
cd ../annotations/Scscl.PRJNA140539

echo Scscl.PRJNA140539.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA140539.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA140539.A.bam
rm /scratch/njohnson/Scscl.PRJNA140539.A.bam



