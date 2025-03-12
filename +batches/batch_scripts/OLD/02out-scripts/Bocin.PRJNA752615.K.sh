#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.K

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.K.bam
yasma.py tradeoff -o . -n K -ac K -a /scratch/njohnson/Bocin.PRJNA752615.K.bam
rm /scratch/njohnson/Bocin.PRJNA752615.K.bam



