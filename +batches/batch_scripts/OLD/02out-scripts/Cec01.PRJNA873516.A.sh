#!/bin/bash

mkdir ../annotations/Cec01.PRJNA873516
cd ../annotations/Cec01.PRJNA873516

echo Cec01.PRJNA873516.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Cec01.PRJNA873516.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Cec01.PRJNA873516.A.bam
rm /scratch/njohnson/Cec01.PRJNA873516.A.bam



