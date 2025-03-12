#!/bin/bash

mkdir ../annotations/Maory.PRJNA751253
cd ../annotations/Maory.PRJNA751253

echo Maory.PRJNA751253.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA751253.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Maory.PRJNA751253.A.bam
rm /scratch/njohnson/Maory.PRJNA751253.A.bam



