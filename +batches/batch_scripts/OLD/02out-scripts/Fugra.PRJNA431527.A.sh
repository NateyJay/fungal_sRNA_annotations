#!/bin/bash

mkdir ../annotations/Fugra.PRJNA431527
cd ../annotations/Fugra.PRJNA431527

echo Fugra.PRJNA431527.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA431527.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fugra.PRJNA431527.A.bam
rm /scratch/njohnson/Fugra.PRJNA431527.A.bam



