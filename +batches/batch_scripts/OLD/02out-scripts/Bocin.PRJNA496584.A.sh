#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA496584.A.bam
rm /scratch/njohnson/Bocin.PRJNA496584.A.bam



