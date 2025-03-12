#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA476756.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Blgra.PRJNA476756.A.bam
rm /scratch/njohnson/Blgra.PRJNA476756.A.bam



