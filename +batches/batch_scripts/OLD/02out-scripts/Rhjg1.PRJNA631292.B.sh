#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhjg1.PRJNA631292.B.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.B.bam



