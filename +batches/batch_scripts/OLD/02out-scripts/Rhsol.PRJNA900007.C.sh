#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA900007.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Rhsol.PRJNA900007.C.bam
rm /scratch/njohnson/Rhsol.PRJNA900007.C.bam



