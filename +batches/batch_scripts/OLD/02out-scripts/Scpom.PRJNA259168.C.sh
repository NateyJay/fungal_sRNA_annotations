#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259168
cd ../annotations/Scpom.PRJNA259168

echo Scpom.PRJNA259168.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259168.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Scpom.PRJNA259168.C.bam
rm /scratch/njohnson/Scpom.PRJNA259168.C.bam



