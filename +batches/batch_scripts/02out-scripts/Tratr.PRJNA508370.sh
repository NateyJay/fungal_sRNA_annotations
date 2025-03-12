#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Tratr.PRJNA508370.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR8280354:A SRR8280352:A SRR8280353:A SRR8280361:B SRR8280363:B SRR8280362:B SRR8280359:C SRR8280360:C SRR8280358:C SRR8280356:D SRR8280357:D SRR8280355:D -a /scratch/njohnson/Tratr.PRJNA508370.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Tratr.PRJNA508370.bam
rm /scratch/njohnson/Tratr.PRJNA508370.bam.bai
rm /scratch/njohnson/Tratr.PRJNA508370.depth.txt



