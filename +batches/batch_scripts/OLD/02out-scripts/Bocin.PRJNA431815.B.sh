#!/bin/bash

mkdir ../annotations/Bocin.PRJNA431815
cd ../annotations/Bocin.PRJNA431815

echo Bocin.PRJNA431815.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA431815.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bocin.PRJNA431815.B.bam
rm /scratch/njohnson/Bocin.PRJNA431815.B.bam



