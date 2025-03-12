#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Maory.PRJNA310070.E.bam
rm /scratch/njohnson/Maory.PRJNA310070.E.bam



