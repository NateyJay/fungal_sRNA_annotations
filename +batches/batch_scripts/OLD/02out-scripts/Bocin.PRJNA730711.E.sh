#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA730711.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Bocin.PRJNA730711.E.bam
rm /scratch/njohnson/Bocin.PRJNA730711.E.bam



