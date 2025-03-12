#!/bin/bash

mkdir ../annotations/Plcor.PRJNA944818
cd ../annotations/Plcor.PRJNA944818

echo Plcor.PRJNA944818.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Plcor.PRJNA944818.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Plcor.PRJNA944818.B.bam
rm /scratch/njohnson/Plcor.PRJNA944818.B.bam



