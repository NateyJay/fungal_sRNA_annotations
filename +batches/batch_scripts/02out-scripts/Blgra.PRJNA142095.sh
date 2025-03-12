#!/bin/bash

mkdir ../annotations/Blgra.PRJNA142095
cd ../annotations/Blgra.PRJNA142095

echo Blgra.PRJNA142095


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Blgra.PRJNA142095.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR101428:A SRR101430:B -a /scratch/njohnson/Blgra.PRJNA142095.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Blgra.PRJNA142095.bam
rm /scratch/njohnson/Blgra.PRJNA142095.bam.bai
rm /scratch/njohnson/Blgra.PRJNA142095.depth.txt



