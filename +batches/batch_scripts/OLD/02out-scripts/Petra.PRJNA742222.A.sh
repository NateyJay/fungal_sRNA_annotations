#!/bin/bash

mkdir ../annotations/Petra.PRJNA742222
cd ../annotations/Petra.PRJNA742222

echo Petra.PRJNA742222.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Petra.PRJNA742222.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Petra.PRJNA742222.A.bam
rm /scratch/njohnson/Petra.PRJNA742222.A.bam



