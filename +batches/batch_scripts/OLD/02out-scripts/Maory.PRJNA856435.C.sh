#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA856435.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Maory.PRJNA856435.C.bam
rm /scratch/njohnson/Maory.PRJNA856435.C.bam



