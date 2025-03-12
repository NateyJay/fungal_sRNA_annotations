#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA232807
cd ../annotations/Fuoxy.PRJNA232807

echo Fuoxy.PRJNA232807.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA232807.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fuoxy.PRJNA232807.A.bam
rm /scratch/njohnson/Fuoxy.PRJNA232807.A.bam



