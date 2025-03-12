#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bocin.PRJNA496584.B.bam
rm /scratch/njohnson/Bocin.PRJNA496584.B.bam



