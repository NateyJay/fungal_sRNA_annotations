#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA429556
cd ../annotations/Rhirr.PRJNA429556

echo Rhirr.PRJNA429556


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA429556.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR6473125:A SRR6473120:A SRR6473126:A SRR6473123:B SRR6473122:B SRR6473124:B -a /scratch/njohnson/Rhirr.PRJNA429556.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhirr.PRJNA429556.bam
rm /scratch/njohnson/Rhirr.PRJNA429556.bam.bai
rm /scratch/njohnson/Rhirr.PRJNA429556.depth.txt



