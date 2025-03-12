#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA248275.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Fugra.PRJNA248275.C.bam
rm /scratch/njohnson/Fugra.PRJNA248275.C.bam



