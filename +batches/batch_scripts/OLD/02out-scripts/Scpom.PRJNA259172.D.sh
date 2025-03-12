#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259172
cd ../annotations/Scpom.PRJNA259172

echo Scpom.PRJNA259172.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259172.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Scpom.PRJNA259172.D.bam
rm /scratch/njohnson/Scpom.PRJNA259172.D.bam



