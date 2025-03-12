#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA496584.C.bam
rm /scratch/njohnson/Bocin.PRJNA496584.C.bam



