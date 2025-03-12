#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA429556
cd ../annotations/Rhirr.PRJNA429556

echo Rhirr.PRJNA429556.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA429556.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Rhirr.PRJNA429556.A.bam
rm /scratch/njohnson/Rhirr.PRJNA429556.A.bam



