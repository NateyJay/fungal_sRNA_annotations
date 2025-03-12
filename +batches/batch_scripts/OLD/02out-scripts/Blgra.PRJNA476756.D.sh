#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA476756.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Blgra.PRJNA476756.D.bam
rm /scratch/njohnson/Blgra.PRJNA476756.D.bam



