#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bodot.PRJNA511629.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Bodot.PRJNA511629.C.bam
rm /scratch/njohnson/Bodot.PRJNA511629.C.bam



