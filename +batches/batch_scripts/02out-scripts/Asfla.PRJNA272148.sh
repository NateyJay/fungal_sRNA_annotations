#!/bin/bash

mkdir ../annotations/Asfla.PRJNA272148
cd ../annotations/Asfla.PRJNA272148

echo Asfla.PRJNA272148


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfla.PRJNA272148.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1748133:A -a /scratch/njohnson/Asfla.PRJNA272148.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfla.PRJNA272148.bam
rm /scratch/njohnson/Asfla.PRJNA272148.bam.bai
rm /scratch/njohnson/Asfla.PRJNA272148.depth.txt



