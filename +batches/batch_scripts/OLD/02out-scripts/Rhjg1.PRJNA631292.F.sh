#!/bin/bash

mkdir ../annotations/Rhjg1.PRJNA631292
cd ../annotations/Rhjg1.PRJNA631292

echo Rhjg1.PRJNA631292.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhjg1.PRJNA631292.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Rhjg1.PRJNA631292.F.bam
rm /scratch/njohnson/Rhjg1.PRJNA631292.F.bam



