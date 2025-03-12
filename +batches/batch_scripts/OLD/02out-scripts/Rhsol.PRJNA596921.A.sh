#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA596921
cd ../annotations/Rhsol.PRJNA596921

echo Rhsol.PRJNA596921.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA596921.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhsol.PRJNA596921.A.bam
rm /scratch/njohnson/Rhsol.PRJNA596921.A.bam



