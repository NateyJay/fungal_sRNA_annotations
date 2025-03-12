#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Bocin.PRJNA496584.D.bam
rm /scratch/njohnson/Bocin.PRJNA496584.D.bam



