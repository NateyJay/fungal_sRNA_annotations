#!/bin/bash

mkdir ../annotations/Glint.PRJNA142331
cd ../annotations/Glint.PRJNA142331

echo Glint.PRJNA142331.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Glint.PRJNA142331.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Glint.PRJNA142331.A.bam
rm /scratch/njohnson/Glint.PRJNA142331.A.bam



