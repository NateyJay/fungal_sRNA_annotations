#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253153
cd ../annotations/Fugra.PRJNA253153

echo Fugra.PRJNA253153.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA253153.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fugra.PRJNA253153.A.bam
rm /scratch/njohnson/Fugra.PRJNA253153.A.bam



