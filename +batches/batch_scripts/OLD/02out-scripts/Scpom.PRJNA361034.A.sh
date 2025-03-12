#!/bin/bash

mkdir ../annotations/Scpom.PRJNA361034
cd ../annotations/Scpom.PRJNA361034

echo Scpom.PRJNA361034.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA361034.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA361034.A.bam
rm /scratch/njohnson/Scpom.PRJNA361034.A.bam



