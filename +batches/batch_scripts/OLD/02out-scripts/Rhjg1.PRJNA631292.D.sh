#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Rhjg1.PRJNA631292.D.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.D.bam



