#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259172
cd ../annotations/Scpom.PRJNA259172

echo Scpom.PRJNA259172.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259172.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scpom.PRJNA259172.B.bam
rm /scratch/njohnson/Scpom.PRJNA259172.B.bam



