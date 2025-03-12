#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA348385.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Scscl.PRJNA348385.D.bam
rm /scratch/njohnson/Scscl.PRJNA348385.D.bam



