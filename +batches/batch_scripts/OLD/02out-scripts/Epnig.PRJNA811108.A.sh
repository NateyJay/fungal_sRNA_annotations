#!/bin/bash

mkdir ../annotations/Epnig.PRJNA811108
cd ../annotations/Epnig.PRJNA811108

echo Epnig.PRJNA811108.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Epnig.PRJNA811108.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Epnig.PRJNA811108.A.bam
rm /scratch/njohnson/Epnig.PRJNA811108.A.bam



