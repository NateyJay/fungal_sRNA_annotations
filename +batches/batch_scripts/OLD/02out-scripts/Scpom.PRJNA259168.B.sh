#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259168
cd ../annotations/Scpom.PRJNA259168

echo Scpom.PRJNA259168.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259168.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scpom.PRJNA259168.B.bam
rm /scratch/njohnson/Scpom.PRJNA259168.B.bam



