#!/bin/bash

mkdir ../annotations/Necra.PRJNA167682
cd ../annotations/Necra.PRJNA167682

echo Necra.PRJNA167682


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA167682.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR502771:A -a /scratch/njohnson/Necra.PRJNA167682.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Necra.PRJNA167682.bam
rm /scratch/njohnson/Necra.PRJNA167682.bam.bai
rm /scratch/njohnson/Necra.PRJNA167682.depth.txt



