#!/bin/bash

mkdir ../annotations/Alalt.PRJNA475703
cd ../annotations/Alalt.PRJNA475703

echo Alalt.PRJNA475703.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Alalt.PRJNA475703.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Alalt.PRJNA475703.A.bam
rm /scratch/njohnson/Alalt.PRJNA475703.A.bam



