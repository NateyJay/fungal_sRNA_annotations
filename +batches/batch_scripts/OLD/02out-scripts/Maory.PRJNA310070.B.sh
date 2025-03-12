#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Maory.PRJNA310070.B.bam
rm /scratch/njohnson/Maory.PRJNA310070.B.bam



