#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhsol.PRJNA282111.A.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.A.bam



