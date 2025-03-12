#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA232807
cd ../annotations/Fuoxy.PRJNA232807

echo Fuoxy.PRJNA232807


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA232807.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1068199:A -a /scratch/njohnson/Fuoxy.PRJNA232807.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA232807.bam
rm /scratch/njohnson/Fuoxy.PRJNA232807.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA232807.depth.txt



