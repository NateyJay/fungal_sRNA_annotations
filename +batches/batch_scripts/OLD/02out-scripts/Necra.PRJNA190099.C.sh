#!/bin/bash

mkdir ../annotations/Necra.PRJNA190099
cd ../annotations/Necra.PRJNA190099

echo Necra.PRJNA190099.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA190099.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Necra.PRJNA190099.C.bam
rm /scratch/njohnson/Necra.PRJNA190099.C.bam



