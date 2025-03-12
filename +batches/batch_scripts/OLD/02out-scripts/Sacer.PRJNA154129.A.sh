#!/bin/bash

mkdir ../annotations/Sacer.PRJNA154129
cd ../annotations/Sacer.PRJNA154129

echo Sacer.PRJNA154129.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Sacer.PRJNA154129.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Sacer.PRJNA154129.A.bam
rm /scratch/njohnson/Sacer.PRJNA154129.A.bam



