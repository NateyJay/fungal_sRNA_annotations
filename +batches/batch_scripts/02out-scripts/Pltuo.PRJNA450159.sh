#!/bin/bash

mkdir ../annotations/Pltuo.PRJNA450159
cd ../annotations/Pltuo.PRJNA450159

echo Pltuo.PRJNA450159


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pltuo.PRJNA450159.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B -c SRR7003639:B -a /scratch/njohnson/Pltuo.PRJNA450159.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pltuo.PRJNA450159.bam
rm /scratch/njohnson/Pltuo.PRJNA450159.bam.bai
rm /scratch/njohnson/Pltuo.PRJNA450159.depth.txt



