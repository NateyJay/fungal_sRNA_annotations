#!/bin/bash

mkdir ../annotations/Maory.PRJNA185495
cd ../annotations/Maory.PRJNA185495

echo Maory.PRJNA185495.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA185495.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Maory.PRJNA185495.C.bam
rm /scratch/njohnson/Maory.PRJNA185495.C.bam



