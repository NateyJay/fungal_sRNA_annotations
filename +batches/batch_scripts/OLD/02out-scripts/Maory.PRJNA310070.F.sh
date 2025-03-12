#!/bin/bash

mkdir ../annotations/Maory.PRJNA310070
cd ../annotations/Maory.PRJNA310070

echo Maory.PRJNA310070.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA310070.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Maory.PRJNA310070.F.bam
rm /scratch/njohnson/Maory.PRJNA310070.F.bam



