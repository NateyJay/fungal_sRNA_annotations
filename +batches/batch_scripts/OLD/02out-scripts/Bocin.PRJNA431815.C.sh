#!/bin/bash

mkdir ../annotations/Bocin.PRJNA431815
cd ../annotations/Bocin.PRJNA431815

echo Bocin.PRJNA431815.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA431815.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA431815.C.bam
rm /scratch/njohnson/Bocin.PRJNA431815.C.bam



