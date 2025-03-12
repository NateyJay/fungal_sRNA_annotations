#!/bin/bash

mkdir ../annotations/Focan.PRJNA705837
cd ../annotations/Focan.PRJNA705837

echo Focan.PRJNA705837


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Focan.PRJNA705837.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR13823661:A -a /scratch/njohnson/Focan.PRJNA705837.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Focan.PRJNA705837.bam
rm /scratch/njohnson/Focan.PRJNA705837.bam.bai
rm /scratch/njohnson/Focan.PRJNA705837.depth.txt



