#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Rhsol.PRJNA282111.G.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.G.bam



