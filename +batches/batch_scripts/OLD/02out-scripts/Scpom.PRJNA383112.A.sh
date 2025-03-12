#!/bin/bash

mkdir ../annotations/Scpom.PRJNA383112
cd ../annotations/Scpom.PRJNA383112

echo Scpom.PRJNA383112.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA383112.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scpom.PRJNA383112.A.bam
rm /scratch/njohnson/Scpom.PRJNA383112.A.bam



