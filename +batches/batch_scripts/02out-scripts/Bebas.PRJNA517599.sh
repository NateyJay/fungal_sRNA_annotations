#!/bin/bash

mkdir ../annotations/Bebas.PRJNA517599
cd ../annotations/Bebas.PRJNA517599

echo Bebas.PRJNA517599


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bebas.PRJNA517599.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR8501350:A SRR8501349:B SRR8501348:C -a /scratch/njohnson/Bebas.PRJNA517599.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bebas.PRJNA517599.bam
rm /scratch/njohnson/Bebas.PRJNA517599.bam.bai
rm /scratch/njohnson/Bebas.PRJNA517599.depth.txt



