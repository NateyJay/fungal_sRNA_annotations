#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA348385.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Scscl.PRJNA348385.E.bam
rm /scratch/njohnson/Scscl.PRJNA348385.E.bam



