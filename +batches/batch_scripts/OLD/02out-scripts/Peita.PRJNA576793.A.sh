#!/bin/bash

mkdir ../annotations/Peita.PRJNA576793
cd ../annotations/Peita.PRJNA576793

echo Peita.PRJNA576793.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Peita.PRJNA576793.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Peita.PRJNA576793.A.bam
rm /scratch/njohnson/Peita.PRJNA576793.A.bam



