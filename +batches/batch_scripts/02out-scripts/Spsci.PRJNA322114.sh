#!/bin/bash

mkdir ../annotations/Spsci.PRJNA322114
cd ../annotations/Spsci.PRJNA322114

echo Spsci.PRJNA322114


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Spsci.PRJNA322114.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR3546731:A SRR3546721:A -a /scratch/njohnson/Spsci.PRJNA322114.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Spsci.PRJNA322114.bam
rm /scratch/njohnson/Spsci.PRJNA322114.bam.bai
rm /scratch/njohnson/Spsci.PRJNA322114.depth.txt



