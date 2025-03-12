#!/bin/bash

mkdir ../annotations/Bebas.PRJNA647702
cd ../annotations/Bebas.PRJNA647702

echo Bebas.PRJNA647702


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA647702.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR12284227:A SRR12284226:A SRR12284230:B SRR12284229:B SRR12284228:B -a /scratch/njohnson/Bebas.PRJNA647702.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bebas.PRJNA647702.bam
rm /scratch/njohnson/Bebas.PRJNA647702.bam.bai
rm /scratch/njohnson/Bebas.PRJNA647702.depth.txt



