#!/bin/bash

mkdir ../annotations/Asfum.PRJNA926984
cd ../annotations/Asfum.PRJNA926984

echo Asfum.PRJNA926984.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA926984.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Asfum.PRJNA926984.A.bam
rm /scratch/njohnson/Asfum.PRJNA926984.A.bam



