#!/bin/bash

mkdir ../annotations/Bebas.PRJNA647702
cd ../annotations/Bebas.PRJNA647702

echo Bebas.PRJNA647702.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA647702.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bebas.PRJNA647702.A.bam
rm /scratch/njohnson/Bebas.PRJNA647702.A.bam



