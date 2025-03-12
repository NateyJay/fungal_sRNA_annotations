#!/bin/bash

mkdir ../annotations/Maory.PRJNA504419
cd ../annotations/Maory.PRJNA504419

echo Maory.PRJNA504419.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA504419.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Maory.PRJNA504419.A.bam
rm /scratch/njohnson/Maory.PRJNA504419.A.bam



