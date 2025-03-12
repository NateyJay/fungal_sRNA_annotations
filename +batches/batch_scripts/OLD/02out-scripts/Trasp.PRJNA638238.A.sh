#!/bin/bash

mkdir ../annotations/Trasp.PRJNA638238
cd ../annotations/Trasp.PRJNA638238

echo Trasp.PRJNA638238.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Trasp.PRJNA638238.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Trasp.PRJNA638238.A.bam
rm /scratch/njohnson/Trasp.PRJNA638238.A.bam



