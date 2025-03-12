#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA730711.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA730711.C.bam
rm /scratch/njohnson/Bocin.PRJNA730711.C.bam



