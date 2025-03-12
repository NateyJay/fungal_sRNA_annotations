#!/bin/bash

mkdir ../annotations/Tamar.PRJNA647397
cd ../annotations/Tamar.PRJNA647397

echo Tamar.PRJNA647397.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tamar.PRJNA647397.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Tamar.PRJNA647397.A.bam
rm /scratch/njohnson/Tamar.PRJNA647397.A.bam



