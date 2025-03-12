#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhsol.PRJNA282111.C.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.C.bam



