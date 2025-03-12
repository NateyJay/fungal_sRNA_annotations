#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Mulus.PRJNA903107.G.bam
rm /scratch/njohnson/Mulus.PRJNA903107.G.bam



