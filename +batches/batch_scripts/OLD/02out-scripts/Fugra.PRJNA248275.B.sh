#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA248275.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fugra.PRJNA248275.B.bam
rm /scratch/njohnson/Fugra.PRJNA248275.B.bam



