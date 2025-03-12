#!/bin/bash

mkdir ../annotations/Lathe.PRJNA558429
cd ../annotations/Lathe.PRJNA558429

echo Lathe.PRJNA558429


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Lathe.PRJNA558429.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR9903554:A SRR9903553:A SRR9903556:A SRR12538912:B SRR12538913:B SRR12538914:B -a /scratch/njohnson/Lathe.PRJNA558429.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Lathe.PRJNA558429.bam
rm /scratch/njohnson/Lathe.PRJNA558429.bam.bai
rm /scratch/njohnson/Lathe.PRJNA558429.depth.txt



