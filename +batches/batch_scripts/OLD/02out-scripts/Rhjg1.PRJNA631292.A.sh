#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhjg1.PRJNA631292.A.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.A.bam



