#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA304218.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Fugra.PRJNA304218.D.bam
rm /scratch/njohnson/Fugra.PRJNA304218.D.bam



