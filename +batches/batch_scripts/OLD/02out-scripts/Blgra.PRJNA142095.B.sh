#!/bin/bash

mkdir ../annotations/Blgra.PRJNA142095
cd ../annotations/Blgra.PRJNA142095

echo Blgra.PRJNA142095.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA142095.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Blgra.PRJNA142095.B.bam
rm /scratch/njohnson/Blgra.PRJNA142095.B.bam



