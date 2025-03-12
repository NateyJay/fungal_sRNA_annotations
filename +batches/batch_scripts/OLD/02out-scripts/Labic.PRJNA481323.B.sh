#!/bin/bash

mkdir ../annotations/Labic.PRJNA481323
cd ../annotations/Labic.PRJNA481323

echo Labic.PRJNA481323.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Labic.PRJNA481323.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Labic.PRJNA481323.B.bam
rm /scratch/njohnson/Labic.PRJNA481323.B.bam



