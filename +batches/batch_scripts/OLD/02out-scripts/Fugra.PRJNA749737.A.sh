#!/bin/bash

mkdir ../annotations/Fugra.PRJNA749737
cd ../annotations/Fugra.PRJNA749737

echo Fugra.PRJNA749737.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA749737.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fugra.PRJNA749737.A.bam
rm /scratch/njohnson/Fugra.PRJNA749737.A.bam



