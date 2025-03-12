#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA431527.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fugra.PRJNA431527.B.bam
rm /scratch/njohnson/Fugra.PRJNA431527.B.bam



