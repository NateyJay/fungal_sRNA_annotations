#!/bin/bash

mkdir ../annotations/Nocer.PRJNA408312
cd ../annotations/Nocer.PRJNA408312

echo Nocer.PRJNA408312.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA408312.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Nocer.PRJNA408312.B.bam
rm /scratch/njohnson/Nocer.PRJNA408312.B.bam



