#!/bin/bash

mkdir ../annotations/Scpom.PRJNA341984
cd ../annotations/Scpom.PRJNA341984

echo Scpom.PRJNA341984.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA341984.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Scpom.PRJNA341984.D.bam
rm /scratch/njohnson/Scpom.PRJNA341984.D.bam



