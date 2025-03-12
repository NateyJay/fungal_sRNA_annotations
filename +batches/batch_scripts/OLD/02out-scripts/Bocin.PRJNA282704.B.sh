#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282704
cd ../annotations/Bocin.PRJNA282704

echo Bocin.PRJNA282704.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA282704.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bocin.PRJNA282704.B.bam
rm /scratch/njohnson/Bocin.PRJNA282704.B.bam



