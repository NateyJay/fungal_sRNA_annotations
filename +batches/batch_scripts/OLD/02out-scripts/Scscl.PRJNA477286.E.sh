#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA477286.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Scscl.PRJNA477286.E.bam
rm /scratch/njohnson/Scscl.PRJNA477286.E.bam



