#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193537
cd ../annotations/Bocin.PRJNA193537

echo Bocin.PRJNA193537.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193537.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA193537.C.bam
rm /scratch/njohnson/Bocin.PRJNA193537.C.bam



