#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA476756.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Blgra.PRJNA476756.B.bam
rm /scratch/njohnson/Blgra.PRJNA476756.B.bam



