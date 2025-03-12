#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530565
cd ../annotations/Nacas.PRJNA530565

echo Nacas.PRJNA530565.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA530565.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nacas.PRJNA530565.A.bam
rm /scratch/njohnson/Nacas.PRJNA530565.A.bam



