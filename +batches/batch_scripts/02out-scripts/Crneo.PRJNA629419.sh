#!/bin/bash

mkdir ../annotations/Crneo.PRJNA629419
cd ../annotations/Crneo.PRJNA629419

echo Crneo.PRJNA629419


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Crneo.PRJNA629419.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR11648392:A -a /scratch/njohnson/Crneo.PRJNA629419.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Crneo.PRJNA629419.bam
rm /scratch/njohnson/Crneo.PRJNA629419.bam.bai
rm /scratch/njohnson/Crneo.PRJNA629419.depth.txt



