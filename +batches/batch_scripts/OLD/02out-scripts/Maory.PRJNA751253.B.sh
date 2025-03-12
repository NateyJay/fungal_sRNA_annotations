#!/bin/bash

mkdir ../annotations/Maory.PRJNA751253
cd ../annotations/Maory.PRJNA751253

echo Maory.PRJNA751253.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA751253.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Maory.PRJNA751253.B.bam
rm /scratch/njohnson/Maory.PRJNA751253.B.bam



