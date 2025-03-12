#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA407898
cd ../annotations/Fuoxy.PRJNA407898

echo Fuoxy.PRJNA407898.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA407898.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fuoxy.PRJNA407898.A.bam
rm /scratch/njohnson/Fuoxy.PRJNA407898.A.bam



