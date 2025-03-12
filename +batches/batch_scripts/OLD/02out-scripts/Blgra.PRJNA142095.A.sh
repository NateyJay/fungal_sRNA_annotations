#!/bin/bash

mkdir ../annotations/Blgra.PRJNA142095
cd ../annotations/Blgra.PRJNA142095

echo Blgra.PRJNA142095.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA142095.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Blgra.PRJNA142095.A.bam
rm /scratch/njohnson/Blgra.PRJNA142095.A.bam



