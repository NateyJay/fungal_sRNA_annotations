#!/bin/bash

mkdir ../annotations/Opsin.PRJNA673414
cd ../annotations/Opsin.PRJNA673414

echo Opsin.PRJNA673414.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Opsin.PRJNA673414.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Opsin.PRJNA673414.C.bam
rm /scratch/njohnson/Opsin.PRJNA673414.C.bam



