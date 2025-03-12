#!/bin/bash

mkdir ../annotations/Alalt.PRJNA475703
cd ../annotations/Alalt.PRJNA475703

echo Alalt.PRJNA475703.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Alalt.PRJNA475703.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Alalt.PRJNA475703.B.bam
rm /scratch/njohnson/Alalt.PRJNA475703.B.bam



