#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA282111
cd ../annotations/Rhsol.PRJNA282111

echo Rhsol.PRJNA282111.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA282111.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhsol.PRJNA282111.B.bam
rm /scratch/njohnson/Rhsol.PRJNA282111.B.bam



