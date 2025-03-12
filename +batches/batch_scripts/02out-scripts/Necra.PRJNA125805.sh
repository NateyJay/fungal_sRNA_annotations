#!/bin/bash

mkdir ../annotations/Necra.PRJNA125805
cd ../annotations/Necra.PRJNA125805

echo Necra.PRJNA125805


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Necra.PRJNA125805.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR039817:A -a /scratch/njohnson/Necra.PRJNA125805.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Necra.PRJNA125805.bam
rm /scratch/njohnson/Necra.PRJNA125805.bam.bai
rm /scratch/njohnson/Necra.PRJNA125805.depth.txt



