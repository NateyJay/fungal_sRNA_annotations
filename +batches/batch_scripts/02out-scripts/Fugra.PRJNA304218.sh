#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA304218.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR2970501:A SRR3055828:B SRR3055829:C SRR3055827:D -a /scratch/njohnson/Fugra.PRJNA304218.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fugra.PRJNA304218.bam
rm /scratch/njohnson/Fugra.PRJNA304218.bam.bai
rm /scratch/njohnson/Fugra.PRJNA304218.depth.txt



