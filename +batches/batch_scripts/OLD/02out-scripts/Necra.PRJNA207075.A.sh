#!/bin/bash

mkdir ../annotations/Necra.PRJNA207075
cd ../annotations/Necra.PRJNA207075

echo Necra.PRJNA207075.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA207075.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Necra.PRJNA207075.A.bam
rm /scratch/njohnson/Necra.PRJNA207075.A.bam



