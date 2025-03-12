#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Maory.PRJNA310070.G.bam
rm /scratch/njohnson/Maory.PRJNA310070.G.bam



