#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.N

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.N.bam
yasma.py tradeoff -o . -n N -ac N -a /scratch/njohnson/Bocin.PRJNA752615.N.bam
rm /scratch/njohnson/Bocin.PRJNA752615.N.bam



