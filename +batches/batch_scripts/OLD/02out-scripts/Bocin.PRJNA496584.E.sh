#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Bocin.PRJNA496584.E.bam
rm /scratch/njohnson/Bocin.PRJNA496584.E.bam



