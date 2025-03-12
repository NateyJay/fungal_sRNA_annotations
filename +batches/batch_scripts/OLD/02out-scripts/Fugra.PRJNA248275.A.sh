#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA248275.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fugra.PRJNA248275.A.bam
rm /scratch/njohnson/Fugra.PRJNA248275.A.bam



