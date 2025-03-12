#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA476756.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Blgra.PRJNA476756.C.bam
rm /scratch/njohnson/Blgra.PRJNA476756.C.bam



