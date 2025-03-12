#!/bin/bash

mkdir ../annotations/Putri.PRJNA266709
cd ../annotations/Putri.PRJNA266709

echo Putri.PRJNA266709.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Putri.PRJNA266709.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Putri.PRJNA266709.A.bam
rm /scratch/njohnson/Putri.PRJNA266709.A.bam



