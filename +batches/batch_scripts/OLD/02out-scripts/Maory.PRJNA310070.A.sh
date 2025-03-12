#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Maory.PRJNA310070.A.bam
rm /scratch/njohnson/Maory.PRJNA310070.A.bam



