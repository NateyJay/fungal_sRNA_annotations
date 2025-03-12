#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA730711.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Bocin.PRJNA730711.D.bam
rm /scratch/njohnson/Bocin.PRJNA730711.D.bam



