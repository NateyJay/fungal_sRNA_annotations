#!/bin/bash

mkdir ../annotations/Blgra.PRJNA476756
cd ../annotations/Blgra.PRJNA476756

echo Blgra.PRJNA476756.E

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA476756.E.bam
yasma.py tradeoff -o . -n E -ac E -a /scratch/njohnson/Blgra.PRJNA476756.E.bam
rm /scratch/njohnson/Blgra.PRJNA476756.E.bam



