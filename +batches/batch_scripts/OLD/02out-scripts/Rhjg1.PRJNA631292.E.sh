#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Rhjg1.PRJNA631292.E.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.E.bam



