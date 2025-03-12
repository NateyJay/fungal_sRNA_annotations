#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA722321.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhirr.PRJNA722321.C.bam
rm /scratch/njohnson/Rhirr.PRJNA722321.C.bam



