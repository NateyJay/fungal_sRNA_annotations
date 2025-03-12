#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA477286.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Scscl.PRJNA477286.D.bam
rm /scratch/njohnson/Scscl.PRJNA477286.D.bam



