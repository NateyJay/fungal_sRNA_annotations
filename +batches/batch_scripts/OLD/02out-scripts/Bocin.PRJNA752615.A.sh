#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bocin.PRJNA752615.A.bam
rm /scratch/njohnson/Bocin.PRJNA752615.A.bam



