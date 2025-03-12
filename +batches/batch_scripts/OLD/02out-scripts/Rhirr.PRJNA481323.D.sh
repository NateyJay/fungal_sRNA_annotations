#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA481323
cd ../annotations/Rhirr.PRJNA481323

echo Rhirr.PRJNA481323.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA481323.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Rhirr.PRJNA481323.D.bam
rm /scratch/njohnson/Rhirr.PRJNA481323.D.bam



