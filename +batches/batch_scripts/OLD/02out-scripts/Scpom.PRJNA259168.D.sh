#!/bin/bash

mkdir ../annotations/Scpom.PRJNA259168
cd ../annotations/Scpom.PRJNA259168

echo Scpom.PRJNA259168.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA259168.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Scpom.PRJNA259168.D.bam
rm /scratch/njohnson/Scpom.PRJNA259168.D.bam



