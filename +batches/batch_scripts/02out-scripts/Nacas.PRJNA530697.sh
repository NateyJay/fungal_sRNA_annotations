#!/bin/bash

mkdir ../annotations/Nacas.PRJNA530697
cd ../annotations/Nacas.PRJNA530697

echo Nacas.PRJNA530697


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nacas.PRJNA530697.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR9710748:A -a /scratch/njohnson/Nacas.PRJNA530697.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nacas.PRJNA530697.bam
rm /scratch/njohnson/Nacas.PRJNA530697.bam.bai
rm /scratch/njohnson/Nacas.PRJNA530697.depth.txt



