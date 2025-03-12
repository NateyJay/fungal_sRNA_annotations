#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA213313
cd ../annotations/Rhirr.PRJNA213313

echo Rhirr.PRJNA213313.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA213313.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhirr.PRJNA213313.C.bam
rm /scratch/njohnson/Rhirr.PRJNA213313.C.bam



