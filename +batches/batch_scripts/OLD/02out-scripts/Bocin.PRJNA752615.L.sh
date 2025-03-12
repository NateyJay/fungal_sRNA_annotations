#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.L

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.L.bam
yasma.py tradeoff -o . -n L -ac L -a /scratch/njohnson/Bocin.PRJNA752615.L.bam
rm /scratch/njohnson/Bocin.PRJNA752615.L.bam



