#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Bocin.PRJNA496584.G.bam
rm /scratch/njohnson/Bocin.PRJNA496584.G.bam



