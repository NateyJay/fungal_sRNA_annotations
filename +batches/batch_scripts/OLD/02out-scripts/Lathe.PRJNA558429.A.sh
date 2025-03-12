#!/bin/bash

mkdir ../annotations/Lathe.PRJNA558429
cd ../annotations/Lathe.PRJNA558429

echo Lathe.PRJNA558429.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Lathe.PRJNA558429.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Lathe.PRJNA558429.A.bam
rm /scratch/njohnson/Lathe.PRJNA558429.A.bam



