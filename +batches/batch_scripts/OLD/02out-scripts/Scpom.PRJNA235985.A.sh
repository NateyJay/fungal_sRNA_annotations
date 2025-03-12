#!/bin/bash

mkdir ../annotations/Scpom.PRJNA235985
cd ../annotations/Scpom.PRJNA235985

echo Scpom.PRJNA235985.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA235985.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA235985.A.bam
rm /scratch/njohnson/Scpom.PRJNA235985.A.bam



