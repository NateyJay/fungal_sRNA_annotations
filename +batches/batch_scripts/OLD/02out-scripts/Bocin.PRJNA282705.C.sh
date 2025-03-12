#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282705
cd ../annotations/Bocin.PRJNA282705

echo Bocin.PRJNA282705.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA282705.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bocin.PRJNA282705.C.bam
rm /scratch/njohnson/Bocin.PRJNA282705.C.bam



