#!/bin/bash

mkdir ../annotations/Pyory.PRJNA322180
cd ../annotations/Pyory.PRJNA322180

echo Pyory.PRJNA322180


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pyory.PRJNA322180.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR3545690:A SRR3545705:A SRR3545705:A SRR3545690:A -a /scratch/njohnson/Pyory.PRJNA322180.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pyory.PRJNA322180.bam
rm /scratch/njohnson/Pyory.PRJNA322180.bam.bai
rm /scratch/njohnson/Pyory.PRJNA322180.depth.txt



