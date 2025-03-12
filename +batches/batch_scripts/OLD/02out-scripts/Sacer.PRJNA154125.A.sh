#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154125
cd ../annotations/Sacer.PRJNA154125

echo Sacer.PRJNA154125.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Sacer.PRJNA154125.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Sacer.PRJNA154125.A.bam
rm /scratch/njohnson/Sacer.PRJNA154125.A.bam



