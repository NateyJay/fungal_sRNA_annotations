#!/bin/bash

mkdir ../annotations/Bocin.PRJNA752615
cd ../annotations/Bocin.PRJNA752615

echo Bocin.PRJNA752615.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA752615.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Bocin.PRJNA752615.F.bam
rm /scratch/njohnson/Bocin.PRJNA752615.F.bam



