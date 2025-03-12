#!/bin/bash

mkdir ../annotations/Plcor.PRJNA944818
cd ../annotations/Plcor.PRJNA944818

echo Plcor.PRJNA944818.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plcor.PRJNA944818.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Plcor.PRJNA944818.C.bam
rm /scratch/njohnson/Plcor.PRJNA944818.C.bam



