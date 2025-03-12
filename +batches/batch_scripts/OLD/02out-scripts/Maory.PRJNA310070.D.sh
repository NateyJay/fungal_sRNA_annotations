#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Maory.PRJNA310070.D.bam
rm /scratch/njohnson/Maory.PRJNA310070.D.bam



