#!/bin/bash

mkdir ../annotations/Bocin.PRJNA325479
cd ../annotations/Bocin.PRJNA325479

echo Bocin.PRJNA325479.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA325479.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA325479.C.bam
rm /scratch/njohnson/Bocin.PRJNA325479.C.bam



