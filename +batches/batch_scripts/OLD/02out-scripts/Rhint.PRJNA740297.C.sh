#!/bin/bash

mkdir ../annotations/Rhint.PRJNA740297
cd ../annotations/Rhint.PRJNA740297

echo Rhint.PRJNA740297.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhint.PRJNA740297.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhint.PRJNA740297.C.bam
rm /scratch/njohnson/Rhint.PRJNA740297.C.bam



