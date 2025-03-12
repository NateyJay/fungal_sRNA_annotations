#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.O

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.O.bam
yasma.py tradeoff -o . -n O -ac O -a /scratch/njohnson/Bocin.PRJNA752615.O.bam
rm /scratch/njohnson/Bocin.PRJNA752615.O.bam



