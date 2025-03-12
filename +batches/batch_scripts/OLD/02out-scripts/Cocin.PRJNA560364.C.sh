#!/bin/bash

mkdir ../annotations/Cocin.PRJNA560364
cd ../annotations/Cocin.PRJNA560364

echo Cocin.PRJNA560364.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA560364.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Cocin.PRJNA560364.C.bam
rm /scratch/njohnson/Cocin.PRJNA560364.C.bam



