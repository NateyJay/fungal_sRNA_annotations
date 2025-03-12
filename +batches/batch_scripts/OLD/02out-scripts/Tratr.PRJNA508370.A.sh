#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tratr.PRJNA508370.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Tratr.PRJNA508370.A.bam
rm /scratch/njohnson/Tratr.PRJNA508370.A.bam



