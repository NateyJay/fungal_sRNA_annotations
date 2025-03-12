#!/bin/bash

mkdir ../annotations/Sacer.PRJNA499084
cd ../annotations/Sacer.PRJNA499084

echo Sacer.PRJNA499084.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Sacer.PRJNA499084.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Sacer.PRJNA499084.A.bam
rm /scratch/njohnson/Sacer.PRJNA499084.A.bam



