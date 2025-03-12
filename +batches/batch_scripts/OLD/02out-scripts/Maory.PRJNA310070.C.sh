#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Maory.PRJNA310070.C.bam
rm /scratch/njohnson/Maory.PRJNA310070.C.bam



