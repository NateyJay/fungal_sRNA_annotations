#!/bin/bash

mkdir ../annotations/Glint.PRJNA437917
cd ../annotations/Glint.PRJNA437917

echo Glint.PRJNA437917.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Glint.PRJNA437917.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Glint.PRJNA437917.A.bam
rm /scratch/njohnson/Glint.PRJNA437917.A.bam



