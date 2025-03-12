#!/bin/bash

mkdir ../annotations/Zytri.PRJNA271281
cd ../annotations/Zytri.PRJNA271281

echo Zytri.PRJNA271281


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA271281.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR1738220:A SRR1738218:B -a /scratch/njohnson/Zytri.PRJNA271281.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Zytri.PRJNA271281.bam
rm /scratch/njohnson/Zytri.PRJNA271281.bam.bai
rm /scratch/njohnson/Zytri.PRJNA271281.depth.txt



