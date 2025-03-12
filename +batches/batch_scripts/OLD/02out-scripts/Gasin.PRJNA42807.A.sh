#!/bin/bash

mkdir ../annotations/Gasin.PRJNA42807
cd ../annotations/Gasin.PRJNA42807

echo Gasin.PRJNA42807.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Gasin.PRJNA42807.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Gasin.PRJNA42807.A.bam
rm /scratch/njohnson/Gasin.PRJNA42807.A.bam



