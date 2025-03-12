#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA407898
cd ../annotations/Fuoxy.PRJNA407898

echo Fuoxy.PRJNA407898


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA407898.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR6052682:A SRR6052683:A -a /scratch/njohnson/Fuoxy.PRJNA407898.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA407898.bam
rm /scratch/njohnson/Fuoxy.PRJNA407898.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA407898.depth.txt



