#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA900007.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Rhsol.PRJNA900007.D.bam
rm /scratch/njohnson/Rhsol.PRJNA900007.D.bam



