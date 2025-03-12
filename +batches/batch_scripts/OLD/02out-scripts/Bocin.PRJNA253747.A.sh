#!/bin/bash

mkdir ../annotations/Bocin.PRJNA253747
cd ../annotations/Bocin.PRJNA253747

echo Bocin.PRJNA253747.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA253747.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA253747.A.bam
rm /scratch/njohnson/Bocin.PRJNA253747.A.bam



