#!/bin/bash

mkdir ../annotations/Blgra.PRJNA479878
cd ../annotations/Blgra.PRJNA479878

echo Blgra.PRJNA479878.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA479878.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Blgra.PRJNA479878.A.bam
rm /scratch/njohnson/Blgra.PRJNA479878.A.bam



