#!/bin/bash

mkdir ../annotations/Yalip.PRJNA964764
cd ../annotations/Yalip.PRJNA964764

echo Yalip.PRJNA964764.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Yalip.PRJNA964764.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Yalip.PRJNA964764.B.bam
rm /scratch/njohnson/Yalip.PRJNA964764.B.bam



