#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pustr.PRJNA289147.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Pustr.PRJNA289147.C.bam
rm /scratch/njohnson/Pustr.PRJNA289147.C.bam



