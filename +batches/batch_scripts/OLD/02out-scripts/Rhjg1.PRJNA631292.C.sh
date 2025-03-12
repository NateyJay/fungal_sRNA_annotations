#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhjg1.PRJNA631292.C.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.C.bam



