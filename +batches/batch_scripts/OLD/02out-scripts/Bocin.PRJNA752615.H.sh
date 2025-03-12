#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.H

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.H.bam
yasma.py tradeoff -o . -n H -ac H -a /scratch/njohnson/Bocin.PRJNA752615.H.bam
rm /scratch/njohnson/Bocin.PRJNA752615.H.bam



