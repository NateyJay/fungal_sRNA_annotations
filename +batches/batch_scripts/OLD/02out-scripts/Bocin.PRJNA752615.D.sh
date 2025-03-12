#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Bocin.PRJNA752615.D.bam
rm /scratch/njohnson/Bocin.PRJNA752615.D.bam



