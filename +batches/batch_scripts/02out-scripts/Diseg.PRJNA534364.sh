#!/bin/bash

mkdir ../annotations/Diseg.PRJNA534364
cd ../annotations/Diseg.PRJNA534364

echo Diseg.PRJNA534364


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Diseg.PRJNA534364.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR8948283:A SRR8948284:A SRR8948281:A -a /scratch/njohnson/Diseg.PRJNA534364.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Diseg.PRJNA534364.bam
rm /scratch/njohnson/Diseg.PRJNA534364.bam.bai
rm /scratch/njohnson/Diseg.PRJNA534364.depth.txt



