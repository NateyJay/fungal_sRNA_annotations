#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA730711.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Bocin.PRJNA730711.F.bam
rm /scratch/njohnson/Bocin.PRJNA730711.F.bam



