#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA900007.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Rhsol.PRJNA900007.E.bam
rm /scratch/njohnson/Rhsol.PRJNA900007.E.bam



