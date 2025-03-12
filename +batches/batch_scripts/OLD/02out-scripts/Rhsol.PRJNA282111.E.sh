#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Rhsol.PRJNA282111.E.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.E.bam



