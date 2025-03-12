#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Asrab.PRJNA479940.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Asrab.PRJNA479940.C.bam
rm /scratch/njohnson/Asrab.PRJNA479940.C.bam



