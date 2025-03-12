#!/bin/bash

mkdir ../annotations/Caalb.PRJNA317629
cd ../annotations/Caalb.PRJNA317629

echo Caalb.PRJNA317629.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA317629.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Caalb.PRJNA317629.C.bam
rm /scratch/njohnson/Caalb.PRJNA317629.C.bam



