#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193535
cd ../annotations/Bocin.PRJNA193535

echo Bocin.PRJNA193535.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193535.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA193535.C.bam
rm /scratch/njohnson/Bocin.PRJNA193535.C.bam



