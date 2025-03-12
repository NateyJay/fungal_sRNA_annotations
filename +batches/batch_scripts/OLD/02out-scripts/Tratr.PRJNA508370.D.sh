#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Tratr.PRJNA508370.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Tratr.PRJNA508370.D.bam
rm /scratch/njohnson/Tratr.PRJNA508370.D.bam



