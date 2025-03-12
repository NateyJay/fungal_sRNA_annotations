#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282704
cd ../annotations/Bocin.PRJNA282704

echo Bocin.PRJNA282704.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA282704.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA282704.A.bam
rm /scratch/njohnson/Bocin.PRJNA282704.A.bam



