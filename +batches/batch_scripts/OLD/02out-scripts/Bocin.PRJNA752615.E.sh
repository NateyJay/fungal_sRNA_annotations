#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Bocin.PRJNA752615.E.bam
rm /scratch/njohnson/Bocin.PRJNA752615.E.bam



