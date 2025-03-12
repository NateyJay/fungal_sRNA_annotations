#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA722321.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Rhirr.PRJNA722321.D.bam
rm /scratch/njohnson/Rhirr.PRJNA722321.D.bam



