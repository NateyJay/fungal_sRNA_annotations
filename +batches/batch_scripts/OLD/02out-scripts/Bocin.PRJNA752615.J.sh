#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.J

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.J.bam
yasma.py tradeoff -o . -n J -ac J -a /scratch/njohnson/Bocin.PRJNA752615.J.bam
rm /scratch/njohnson/Bocin.PRJNA752615.J.bam



