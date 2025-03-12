#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tratr.PRJNA508370.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Tratr.PRJNA508370.B.bam
rm /scratch/njohnson/Tratr.PRJNA508370.B.bam



