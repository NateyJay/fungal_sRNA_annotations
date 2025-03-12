#!/bin/bash

mkdir ../annotations/Asfla.PRJNA816993
cd ../annotations/Asfla.PRJNA816993

echo Asfla.PRJNA816993


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA816993.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR24124426:A SRR24124427:A SRR24124425:A SRR24124430:B SRR24124429:B SRR24124428:B -a /scratch/njohnson/Asfla.PRJNA816993.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfla.PRJNA816993.bam
rm /scratch/njohnson/Asfla.PRJNA816993.bam.bai
rm /scratch/njohnson/Asfla.PRJNA816993.depth.txt



