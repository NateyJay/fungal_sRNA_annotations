#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tratr.PRJNA508370.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Tratr.PRJNA508370.C.bam
rm /scratch/njohnson/Tratr.PRJNA508370.C.bam



