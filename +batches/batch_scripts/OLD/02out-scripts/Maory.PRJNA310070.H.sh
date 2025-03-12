#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.H

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.H.bam
yasma.py tradeoff -o . -n H -ac H -a /scratch/njohnson/Maory.PRJNA310070.H.bam
rm /scratch/njohnson/Maory.PRJNA310070.H.bam



