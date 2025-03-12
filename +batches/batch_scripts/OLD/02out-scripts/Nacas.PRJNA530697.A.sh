#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530697
cd ../annotations/Nacas.PRJNA530697

echo Nacas.PRJNA530697.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA530697.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nacas.PRJNA530697.A.bam
rm /scratch/njohnson/Nacas.PRJNA530697.A.bam



