#!/bin/bash

mkdir ../annotations/Fugra.PRJNA347833
cd ../annotations/Fugra.PRJNA347833

echo Fugra.PRJNA347833


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA347833.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR4415737:A -a /scratch/njohnson/Fugra.PRJNA347833.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA347833.bam
rm /scratch/njohnson/Fugra.PRJNA347833.bam.bai
rm /scratch/njohnson/Fugra.PRJNA347833.depth.txt



