#!/bin/bash

mkdir ../annotations/Bebas.PRJNA647702
cd ../annotations/Bebas.PRJNA647702

echo Bebas.PRJNA647702.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA647702.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bebas.PRJNA647702.B.bam
rm /scratch/njohnson/Bebas.PRJNA647702.B.bam



