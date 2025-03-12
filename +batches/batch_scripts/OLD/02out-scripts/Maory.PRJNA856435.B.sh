#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA856435.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Maory.PRJNA856435.B.bam
rm /scratch/njohnson/Maory.PRJNA856435.B.bam



