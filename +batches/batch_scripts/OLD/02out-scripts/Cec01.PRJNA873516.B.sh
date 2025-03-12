#!/bin/bash

mkdir ../annotations/Cec01.PRJNA873516
cd ../annotations/Cec01.PRJNA873516

echo Cec01.PRJNA873516.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cec01.PRJNA873516.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Cec01.PRJNA873516.B.bam
rm /scratch/njohnson/Cec01.PRJNA873516.B.bam



