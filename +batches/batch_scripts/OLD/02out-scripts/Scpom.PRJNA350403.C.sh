#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Scpom.PRJNA350403.C.bam
rm /scratch/njohnson/Scpom.PRJNA350403.C.bam



