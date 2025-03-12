#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA900007.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Rhsol.PRJNA900007.B.bam
rm /scratch/njohnson/Rhsol.PRJNA900007.B.bam



