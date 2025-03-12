#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA304218.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fugra.PRJNA304218.B.bam
rm /scratch/njohnson/Fugra.PRJNA304218.B.bam



