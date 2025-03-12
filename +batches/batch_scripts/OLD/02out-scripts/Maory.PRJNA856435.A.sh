#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA856435.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Maory.PRJNA856435.A.bam
rm /scratch/njohnson/Maory.PRJNA856435.A.bam



