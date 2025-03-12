#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007.H

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA900007.H.bam
yasma.py tradeoff -o . -n H -ac H -a /scratch/njohnson/Rhsol.PRJNA900007.H.bam
rm /scratch/njohnson/Rhsol.PRJNA900007.H.bam



