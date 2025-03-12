#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA304218.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Fugra.PRJNA304218.C.bam
rm /scratch/njohnson/Fugra.PRJNA304218.C.bam



