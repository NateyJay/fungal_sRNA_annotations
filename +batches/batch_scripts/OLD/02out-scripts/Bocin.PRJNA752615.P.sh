#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.P

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.P.bam
yasma.py tradeoff -o . -n P -ac P -a /scratch/njohnson/Bocin.PRJNA752615.P.bam
rm /scratch/njohnson/Bocin.PRJNA752615.P.bam



