#!/bin/bash

mkdir ../annotations/Mulus.PRJNA243024
cd ../annotations/Mulus.PRJNA243024

echo Mulus.PRJNA243024


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA243024.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR1209506:A SRR1209508:B SRR1209509:B SRR1209507:B SRR1209510:C SRR1209511:C -a /scratch/njohnson/Mulus.PRJNA243024.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Mulus.PRJNA243024.bam
rm /scratch/njohnson/Mulus.PRJNA243024.bam.bai
rm /scratch/njohnson/Mulus.PRJNA243024.depth.txt



