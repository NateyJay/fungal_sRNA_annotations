#!/bin/bash

mkdir ../annotations/Scscl.PRJNA607657
cd ../annotations/Scscl.PRJNA607657

echo Scscl.PRJNA607657.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA607657.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA607657.A.bam
rm /scratch/njohnson/Scscl.PRJNA607657.A.bam



