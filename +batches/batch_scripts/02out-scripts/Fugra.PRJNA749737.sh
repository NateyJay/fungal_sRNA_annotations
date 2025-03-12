#!/bin/bash

mkdir ../annotations/Fugra.PRJNA749737
cd ../annotations/Fugra.PRJNA749737

echo Fugra.PRJNA749737


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA749737.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR15248620:A -a /scratch/njohnson/Fugra.PRJNA749737.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA749737.bam
rm /scratch/njohnson/Fugra.PRJNA749737.bam.bai
rm /scratch/njohnson/Fugra.PRJNA749737.depth.txt



