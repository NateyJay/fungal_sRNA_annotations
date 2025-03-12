#!/bin/bash

mkdir ../annotations/Albra.PRJNA556655
cd ../annotations/Albra.PRJNA556655

echo Albra.PRJNA556655.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Albra.PRJNA556655.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Albra.PRJNA556655.A.bam
rm /scratch/njohnson/Albra.PRJNA556655.A.bam



