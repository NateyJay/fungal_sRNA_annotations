#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.I

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.I.bam
yasma.py tradeoff -o . -n I -ac I -a /scratch/njohnson/Bocin.PRJNA752615.I.bam
rm /scratch/njohnson/Bocin.PRJNA752615.I.bam



