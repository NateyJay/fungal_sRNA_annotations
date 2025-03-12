#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.M

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.M.bam
yasma.py tradeoff -o . -n M -ac M -a /scratch/njohnson/Bocin.PRJNA752615.M.bam
rm /scratch/njohnson/Bocin.PRJNA752615.M.bam



