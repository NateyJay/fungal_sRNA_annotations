#!/bin/bash

mkdir ../annotations/Plcor.PRJNA944818
cd ../annotations/Plcor.PRJNA944818

echo Plcor.PRJNA944818.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plcor.PRJNA944818.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Plcor.PRJNA944818.A.bam
rm /scratch/njohnson/Plcor.PRJNA944818.A.bam



