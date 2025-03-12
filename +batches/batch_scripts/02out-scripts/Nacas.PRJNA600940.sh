#!/bin/bash

mkdir ../annotations/Nacas.PRJNA600940
cd ../annotations/Nacas.PRJNA600940

echo Nacas.PRJNA600940


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA600940.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR10877422:A SRR10877419:B -a /scratch/njohnson/Nacas.PRJNA600940.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nacas.PRJNA600940.bam
rm /scratch/njohnson/Nacas.PRJNA600940.bam.bai
rm /scratch/njohnson/Nacas.PRJNA600940.depth.txt



