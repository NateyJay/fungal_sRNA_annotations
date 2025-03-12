#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253151
cd ../annotations/Fugra.PRJNA253151

echo Fugra.PRJNA253151.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA253151.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fugra.PRJNA253151.B.bam
rm /scratch/njohnson/Fugra.PRJNA253151.B.bam



