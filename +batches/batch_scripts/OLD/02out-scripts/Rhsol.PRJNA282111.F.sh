#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Rhsol.PRJNA282111.F.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.F.bam



