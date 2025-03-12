#!/bin/bash

mkdir ../annotations/Scpom.PRJNA120293
cd ../annotations/Scpom.PRJNA120293

echo Scpom.PRJNA120293.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA120293.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA120293.A.bam
rm /scratch/njohnson/Scpom.PRJNA120293.A.bam



