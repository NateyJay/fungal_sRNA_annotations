#!/bin/bash

mkdir ../annotations/Atrol.PRJNA486707
cd ../annotations/Atrol.PRJNA486707

echo Atrol.PRJNA486707


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Atrol.PRJNA486707.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR7754484:A -a /scratch/njohnson/Atrol.PRJNA486707.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Atrol.PRJNA486707.bam
rm /scratch/njohnson/Atrol.PRJNA486707.bam.bai
rm /scratch/njohnson/Atrol.PRJNA486707.depth.txt



