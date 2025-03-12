#!/bin/bash

mkdir ../annotations/Nacas.PRJNA354404
cd ../annotations/Nacas.PRJNA354404

echo Nacas.PRJNA354404.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA354404.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nacas.PRJNA354404.A.bam
rm /scratch/njohnson/Nacas.PRJNA354404.A.bam



