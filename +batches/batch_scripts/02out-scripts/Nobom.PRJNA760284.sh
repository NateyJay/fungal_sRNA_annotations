#!/bin/bash

mkdir ../annotations/Nobom.PRJNA760284
cd ../annotations/Nobom.PRJNA760284

echo Nobom.PRJNA760284


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nobom.PRJNA760284.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR15711005:A -a /scratch/njohnson/Nobom.PRJNA760284.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nobom.PRJNA760284.bam
rm /scratch/njohnson/Nobom.PRJNA760284.bam.bai
rm /scratch/njohnson/Nobom.PRJNA760284.depth.txt



