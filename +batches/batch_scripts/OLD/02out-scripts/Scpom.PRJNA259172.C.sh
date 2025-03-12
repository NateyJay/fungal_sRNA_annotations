#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259172
cd ../annotations/Scpom.PRJNA259172

echo Scpom.PRJNA259172.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259172.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Scpom.PRJNA259172.C.bam
rm /scratch/njohnson/Scpom.PRJNA259172.C.bam



