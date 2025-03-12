#!/bin/bash

mkdir ../annotations/Crneo.PRJNA185599
cd ../annotations/Crneo.PRJNA185599

echo Crneo.PRJNA185599


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Crneo.PRJNA185599.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR646636:A -a /scratch/njohnson/Crneo.PRJNA185599.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Crneo.PRJNA185599.bam
rm /scratch/njohnson/Crneo.PRJNA185599.bam.bai
rm /scratch/njohnson/Crneo.PRJNA185599.depth.txt



