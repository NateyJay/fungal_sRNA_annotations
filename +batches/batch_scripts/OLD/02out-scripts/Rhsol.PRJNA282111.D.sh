#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Rhsol.PRJNA282111.D.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.D.bam



