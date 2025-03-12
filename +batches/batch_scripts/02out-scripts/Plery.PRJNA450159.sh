#!/bin/bash

mkdir ../annotations/Plery.PRJNA450159
cd ../annotations/Plery.PRJNA450159

echo Plery.PRJNA450159


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Plery.PRJNA450159.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR7003643:A -a /scratch/njohnson/Plery.PRJNA450159.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Plery.PRJNA450159.bam
rm /scratch/njohnson/Plery.PRJNA450159.bam.bai
rm /scratch/njohnson/Plery.PRJNA450159.depth.txt



