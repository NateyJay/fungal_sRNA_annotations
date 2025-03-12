#!/bin/bash

mkdir ../annotations/Fugra.PRJNA900007
cd ../annotations/Fugra.PRJNA900007

echo Fugra.PRJNA900007.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA900007.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Fugra.PRJNA900007.G.bam
rm /scratch/njohnson/Fugra.PRJNA900007.G.bam



