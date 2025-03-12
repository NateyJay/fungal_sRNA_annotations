#!/bin/bash

mkdir ../annotations/Scpom.PRJNA177799
cd ../annotations/Scpom.PRJNA177799

echo Scpom.PRJNA177799.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA177799.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA177799.A.bam
rm /scratch/njohnson/Scpom.PRJNA177799.A.bam



