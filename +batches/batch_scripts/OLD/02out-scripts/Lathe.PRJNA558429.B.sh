#!/bin/bash

mkdir ../annotations/Lathe.PRJNA558429
cd ../annotations/Lathe.PRJNA558429

echo Lathe.PRJNA558429.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Lathe.PRJNA558429.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Lathe.PRJNA558429.B.bam
rm /scratch/njohnson/Lathe.PRJNA558429.B.bam



