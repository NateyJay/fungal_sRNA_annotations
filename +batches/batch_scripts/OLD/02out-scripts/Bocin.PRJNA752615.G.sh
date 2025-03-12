#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Bocin.PRJNA752615.G.bam
rm /scratch/njohnson/Bocin.PRJNA752615.G.bam



