#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA481323
cd ../annotations/Rhirr.PRJNA481323

echo Rhirr.PRJNA481323.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA481323.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhirr.PRJNA481323.C.bam
rm /scratch/njohnson/Rhirr.PRJNA481323.C.bam



