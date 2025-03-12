#!/bin/bash

mkdir ../annotations/Maory.PRJNA856435
cd ../annotations/Maory.PRJNA856435

echo Maory.PRJNA856435


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Maory.PRJNA856435.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR20012924:A SRR20012936:B SRR20012922:C -a /scratch/njohnson/Maory.PRJNA856435.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Maory.PRJNA856435.bam
rm /scratch/njohnson/Maory.PRJNA856435.bam.bai
rm /scratch/njohnson/Maory.PRJNA856435.depth.txt



